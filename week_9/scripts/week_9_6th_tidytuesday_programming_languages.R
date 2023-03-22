### My sixth tidytuesday of week 9 ####
### Created by: Avetis Mishegyan #############
### Created on: 2023-03-21 ####################


#### Load Libraries ######
library(tidyverse)
library(here)
library(tidytuesdayR)
library(alphonse) # for alphonse color palette
library(ggplot2)


### Load data ######
tuesdata <- tidytuesdayR::tt_load('2023-03-21') # reads in data using the tidytuesdayR package

languages <- tuesdata$languages
View(languages) # view opens a new window to view the data
glimpse(languages) # glimpse allows us to inspect the data


### Data Analysis ######
number_users <- head(languages) %>% # shows 1st 6 rows
  mutate(title = fct_reorder(title, number_of_users)) %>% # reorders from highest to lowest
  ggplot(aes(x = title,
             y = number_of_users,
             fill = title)) +
  geom_bar(stat = "identity", # bar graph function
           alpha = 1, # sets opacity of bars
           width = .8) + # sets width of bars
  labs(x = "Program Language",
       y = "Number of Users",
       title = "Popularity of Program Languages") +
  coord_flip() + # flips x and y axis
  scale_fill_manual(values = alphonse("mhabakugo")) + # sets bar graph colors
  theme_linedraw() + # sets theme to line draw
  theme(legend.position = "none") + # removes legend
  theme(plot.title = element_text(hjust = .5)) # centers plot title
number_users # prints the plot

ggsave(here("week_9","output","week_9_6th_tidytuesday_programming_languages.png"), # names and saves ggplot
       width = 5, height = 5) # adjust size of graph in inches