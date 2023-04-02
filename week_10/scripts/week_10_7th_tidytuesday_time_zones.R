### My seventh tidytuesday of week 10 ####
### Created by: Avetis Mishegyan #############
### Created on: 2023-03-30 ####################


#### Load Libraries ######
library(tidyverse)
library(here)
library(tidytuesdayR)
library(alphonse) # for alphonse color palette


### Load data ######
tuesdata <- tidytuesdayR::tt_load('2023-01-17') # reads in data using the tidytuesdayR package

arthistory <- tuesdata$artists
View(arthistory) # view opens a new window to view the data
glimpse(arthistory) # glimpse allows us to inspect the data

### Data Analysis ######
book <- arthistory %>%
  drop_na() %>% # removes all NA's
  ggplot(aes(x = year,
             group = book,
             fill = book)) +
  geom_density(adjust = 1.5, # adjust makes adjustments to bandwidth
               show.legend = FALSE) + # removes legend
  labs(x = "Year",
       y = "Density",
       title = "Number of Artist Publications in Two Major Art History Textbooks from 1926-2020") +
  facet_wrap(~book) + # separates density graphs by book
  scale_fill_manual(values = alphonse("jjk")) + # fills density colors using alphonse color palette
  theme_classic() + # sets plot theme to classic
  theme(plot.title = element_text(hjust = .5)) # centers plot title
book # prints the plot

ggsave(here("week_10","output","week_10_7th_tidytuesday_art_history_data.png"), # names and saves ggplot
       width = 10, height = 5) # adjust size of graph in inches