# Data Science for Industry short course

Welcome! This is the course material for the Data Science for Industry short course. The goal of the module is to provide an applied, hands-on overview of selected topics useful in the working world of data science that are not covered by other modules in the program. Broadly speaking these topics fall into two themes: **workflow/productivity tools and skills** (GitHub, data wrangling, visualization, communication) and **modelling** (recommender systems, text mining, neural networks). This is a shortened version of the MSc module of the same name offered Data Science program at the University of Cape Town (if you are looking for that material see [here](https://github.com/iandurbach/datasci-fi)). The short course is accredited by UCT and offered at NQF Level 9.

### Lecture format

The short course is held over 6 session, each roughly two hours. For the most part I'll be basing each lecture around the notebooks below. Sometimes, we'll go through the notebook in class. We won't have time in lectures to go through the notebook in great detail. Mostly I'll be trying to cover the main concepts and give you a good understanding of how things work and fit together, without going into too much detail about each line of code. Most lectures will also give you some time to work through the notebooks on your own, or give you a task or exercise to solve.

Regardless of the lecture type, after the lecture you should go through the notebook at your own pace and absorb all the details, making sure you understand what each bit of code does. Making sure you can reproduce the results on your own i.e. without the notebook, is a good test of understanding. Each notebook will have a few exercises at the end for you to try.

The notebooks will generally cover the topics at an introductory-to-intermediate level. I really hope that you will find them interesting enough to want to learn more (maybe not about *every* topic, but more often than not). There is a huge amount of material on the web about all the topics we'll cover. I'll maintain a list of additional readings (the table above already contains some), but you'll benefit a lot from reading widely. If you find something interesting, let everyone know -- perhaps we can discuss it further in class.

The following is the intended lecture schedule.

|Lecture |  General area   |Topics to be covered | R packages | References
|--------|-----|-------------------------|----------|-------------------
|1        | Wrangling    | Data transformations  | dplyr  | R4DS-ch5 
|        |              | Relational data, join/merge tables | dplyr | R4DS-ch13
|        | Workflow     | R Projects            |   |
|        |              | Github                |   |
|        |              | R Markdown            |   |
|        |           | Cloud computing with AWS | 
|2        | Recommender systems | User/item-based recommenders |  |
|        |                     | Matrix factorization |  |
|3        | Text mining  | Working with text     | stringr | R4DS-ch14 
|        | Text mining  | Analyzing text | tidytext | TMR-ch1, TMR-ch7
|        | | Text generation |  | 
|     | | Bag-of-words models, tf-idf     | tidytext |TMR-ch4
|     | Text mining | Topic modelling | tidytext, topicmodels | TMR-ch6
|4       | Neural networks | Stochastic gradient descent    |     |
|        |                 | Backpropagation                |     |
|        |                 | Introducing *keras*            | keras   |
|5       | Neural networks | Convolutional neural networks | keras    |
|        |               | Computer vision / image classification |   |
|    |  | Sentiment analysis                 | tidytext | TMR-ch2
|    |  | Best practices  |   |
|6       | Communication | Make your own R package | devtools, roxygen2, knitr, testthat  |
|      | Communication | Make your own Shiny app             | shiny

R4DS = R for Data Science (2017) Hadley Wickham and Garrett Grolemund (available at http://r4ds.had.co.nz/)

TMR = Text Mining with R (2017) Julia Silge and David Robinson (available at http://tidytextmining.com/)

The list of packages should be fairly complete. The reference/reading list will be updated as we go.

### Software

To get the most out of the course material you should have the following installed:

* Git and GitHub
* RStudio and R (not too old - I'm using v1.2.1335 of RStudio and R 3.5.1, as of 15/7/2019)

The last of these is not strictly needed but will make it easier to follow in lectures. We'll also need various R packages but you can install these as needed.

### Assessment

If you wish to receive a certificate of completion for the short course you need to attend at least 5 of the 6 sessions and complete a small assignment.

### Contact details

Please email me (ian.durbach@uct.ac.za) to set up an appointment. My office is Room 5.53 in the Dept of Statistical Sciences. 

### Sources and references

I have borrowed extensively from other peoples' material to create this course, and its not my intention to pass off work as my own when its not. My two main sources are [R for Data Science](http://r4ds.had.co.nz/) and [Text Mining with R](http://tidytextmining.com/) listed above, and each notebook has further references to source material, but if you find I've missed an attribution please let me know. As this material will be put on the web, the same goes for any material that is incorrectly shared.