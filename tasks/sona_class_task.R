library(dplyr)
library(tidyr)
library(tidytext)
library(topicmodels)
library(tree)
library(stringr)
library(ggplot2)

load("data/sona_sentences.RData")

sona_words <- sona_sentences %>% unnest_tokens(word, sentence, token = "words")

# what are the most popular words used in a SONA?
sona_words %>% group_by(word) %>% count() %>% ungroup() %>% arrange(desc(n))

# remove stop words
sona_words <- sona_words %>% filter(!(word %in% stop_words$word))

# what are the most popular non-stop words used in a SONA?
sona_words %>% group_by(word) %>% count() %>% ungroup() %>% arrange(desc(n))

# what's the longest sentence anyone has used in a SONA?
sona_words %>% group_by(id) %>% count() %>% ungroup() %>% arrange(desc(n))

# which presidents use longer sentences, on average?
sona_words %>% 
  group_by(id, president_name) %>% count() %>% ungroup() %>% 
  group_by(president_name) %>% summarize(mean_length = mean(n)) %>%
  arrange(desc(mean_length))

# remove any words that were used less than 10 times in total
word_counts_filtered <- sona_words %>% group_by(word) %>% add_tally() %>% ungroup()
word_counts_filtered <- word_counts_filtered %>% filter(n > 50) %>% select(-n)

## get data ready for a predictive model

# make a df containing counts of how many times each word was used in each sentence
df <- word_counts_filtered %>% 
  group_by(id, word) %>% count() %>% ungroup() 

# reshape df from long to wide to get into usual format for predictive models 
# using spread
bag_of_words <- df %>% spread(key = word, value = n, fill = 0) 

# add a new column to the reshaped df containing president 
bag_of_words <- bag_of_words %>%
  left_join(sona_sentences %>% select(id, president_name), by = "id") %>%
  select(-id) %>%
  select(president_name, everything())

# fit classification tree predicting president from word counts
fit <- tree(as.factor(president_name) ~ ., bag_of_words)

plot(fit, main="Full Classification Tree")
text(fit, use.n=TRUE, all=TRUE, cex=.8)

# training accuracy
fitted_train <- predict(fit, type="class")
pred_train <- table(bag_of_words$president_name, fitted_train)
pred_train
sum(diag(pred_train))/sum(pred_train)

# FOR YOU TO TRY:
# try improve on this model; try using bigrams rather than words, or try 
# including less-common words (i.e. setting a less strict filter than n > 50)

#######################
## topic modelling
#######################

# make a df containing counts of how many times each word was used in each SPEECH
df <- word_counts_filtered %>% 
  mutate(speech_id = paste(president_name, year, sep = "_")) %>%
  group_by(speech_id, word) %>% count() %>% ungroup() 

# use cast_dtm to reshape long to wide
dtm_df <- df %>% 
  cast_dtm(speech_id, word, n)

# LDA with 2 topics
set.seed(1234)
lda <- LDA(dtm_df, k = 2)
lda

# create data frame with terms and betas
df_betas <- tidy(lda, matrix = "beta", log = FALSE)
head(df_betas)

# extract the top 20 terms used in each topic and plot these
df_betas %>%
  group_by(topic) %>%
  top_n(20, beta) %>%
  ungroup() %>%
  arrange(topic, -beta) %>%
  mutate(term = reorder(term, beta)) %>%
  ggplot(aes(term, beta, fill = factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ topic, scales = "free") +
  coord_flip()

# FOR YOU TO TRY:
# try creating topics based on bigrams, not words...
# try different numbers of topics...

# the document-topic probabilities create a low-dimensional summary of each
# document, which can be used as features in predictive models. 

# below I show how these can be used to predict which president gave a speech

# extract object containing the document-topic probabilities (gammas)
df_gammas <- tidy(lda, matrix = "gamma", log = FALSE)
  
# reshape from long to wide
df_gammas <- df_gammas %>% spread(key = topic, value = gamma, sep = "_")

# extract president's name from document id
df_gammas <- df_gammas %>% 
  mutate(president_name = str_extract(document, pattern = ".+_")) %>%
  mutate(president_name = str_remove(president_name, "_")) %>% select(-document)

# fit classification tree predicting president from topic probabilities
fit <- tree(as.factor(president_name) ~ ., df_gammas)

plot(fit, main="Full Classification Tree")
text(fit, use.n=TRUE, all=TRUE, cex=.8)

# training accuracy
fitted_train <- predict(fit, type="class")
pred_train <- table(df_gammas$president_name, fitted_train)
pred_train
sum(diag(pred_train))/sum(pred_train)

# FOR YOU TO TRY:
# note the observations/rows in this dataset are entire speeches, not 
# sentences as they were in the previous tree we built. As an exercise, redo
# the topic modelling exercise at the level of sentences i.e. create word counts
# for each sentence (not speech), reshape long to wide, run LDA, extract gammas, 
# and use these features for the classification tree.
