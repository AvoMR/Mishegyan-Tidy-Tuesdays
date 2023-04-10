### My eighth tidytuesday of week 11 ####
### Created by: Avetis Mishegyan #############
### Created on: 2023-04-09 ####################


#### Load Libraries ######
library(tidyverse)
library(here)
library(tidytuesdayR)
library(alphonse) # for alphonse color palette


### Load data ######
# reads in data using the tidytuesdayR package
eggproduction  <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-04-11/egg-production.csv')

View(eggproduction) # view opens a new window to view the data
glimpse(eggproduction) # glimpse allows us to inspect the data


### Data Analysis ######
egg_house <- eggproduction %>%
  drop_na() %>% # removes all NA's
  mutate(log_eggs = log(n_eggs)) %>% # calculates log of n_eggs
  ggplot(aes(x = prod_process,
             y = log_eggs,
             color = prod_process)) +
  geom_jitter(alpha = 0.5, # jitter plot function
              show.legend = FALSE) +
  labs(x = "Production Process and Housing",
       y = "log(number of eggs)",
       title = "Housing Conditions Effects on Eggs Produced in the US from 2007-2021") +
  scale_color_manual(values = alphonse("jjk")) + # colors jitter points using alphonse color palette
  theme_classic() + # sets plot theme to classic
  theme(plot.title = element_text(hjust = .5)) # centers plot title
egg_house

ggsave(here("week_11","output","week_11_8th_tidytuesday_us_egg_production_data.png"), # names and saves ggplot
      width = 10, height = 10) # adjusts size of graph in inches