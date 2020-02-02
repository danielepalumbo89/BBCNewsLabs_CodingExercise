# Load all packages used
if(!require(pacman))install.packages("pacman")

pacman::p_load('dplyr', 'tidyr', 'jsonlite',
               'ggalt', 'lubridate', 'forcats', 'R.utils',
               'tidyverse', 'rvest', 'ggpubr', 'bbplot2')

# Data
blg_dir_assess <- 
  read.csv('~/Downloads/DanieleP_BBCNewsLabs_CodingExercise/data/bulgarian-direct-assessment.csv', stringsAsFactors = FALSE) %>%
    group_by(evaluator.id, sentence.pair.id) 

# 1 - Average by evaluator 
evaluator_average <- aggregate(blg_dir_assess[, 3], list(blg_dir_assess$evaluator.id), mean) %>%
  mutate(score = round(score, 3)) %>%
  arrange(-score) %>%
  rename(Evaluator = Group.1) 

# 1 - Average by evaluator output
  write.csv(evaluator_average, '~/Downloads/DanieleP_BBCNewsLabs_CodingExercise/output/average_by_evaluator.csv')

# 2 - Average by sentence
sentence_average <- aggregate(blg_dir_assess[, 3], list(blg_dir_assess$sentence.pair.id), mean) %>%
  mutate(score = round(score, 2)) %>%
  arrange(-score) %>%
  rename(Sentence = Group.1) 
  
# 2 - Average by sentence output
write.csv(sentence_average, '~/Downloads/DanieleP_BBCNewsLabs_CodingExercise/output/average_by_sentence.csv')
  
# 3 - Highest and Lowest scoring sentences
min_max <- filter(blg_dir_assess, score <= 5 | score >= 95) %>%
  arrange(-score)
  
# 3 - Highest and Lowest scoring sentences output
write.csv(min_max, '~/Downloads/DanieleP_BBCNewsLabs_CodingExercise/output/min_max_score.csv')
