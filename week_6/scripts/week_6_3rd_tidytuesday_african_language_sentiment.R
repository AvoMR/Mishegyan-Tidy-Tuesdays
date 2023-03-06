### My third tidytuesday of week 6 ####
### Created by: Avetis Mishegyan #############
### Created on: 2023-03-05 ####################


#### Load Libraries ######
library(tidyverse)
library(here)
library(viridis)
library(tidytuesdayR)


### Load data ######
tuesdata <- tidytuesdayR::tt_load('2023-02-28') # reads in data using the tidytuesdayR package

afrisenti <- tuesdata$afrisenti
View(afrisenti) # view opens a new window to view the data
glimpse(afrisenti) # glimpse allows us to inspect the data
languages <- tuesdata$languages
View(languages)
glimpse(languages)
language_scripts <- tuesdata$language_scripts
View(language_scripts)
glimpse(language_scripts)
language_countries <- tuesdata$language_countries
View(language_countries)
glimpse(language_countries)
country_regions <- tuesdata$country_regions
View(country_regions)
glimpse(country_regions)


### Data Analysis ######
senti_countries <- left_join(afrisenti, language_countries) # keeps all data from afrisenti and matches data from language_countries
View(senti_countries)

country_v_senti <- senti_countries %>%
  drop_na() %>% # filters out everything that is not a complete row
  group_by(label, country) %>% # groups data by label and country
  count(label) %>% # counts number of negative, neutral, and positive tweets
  ggplot(mapping = aes(x = country,
                       y = label,
                       fill = n)) +
  geom_tile() + # heat map function
  labs(x = "African Country",
       y = "Tweet Sentiments",
       fill = "Tweet Count",
       title = "Tweet Sentiments by African Countries") +
  scale_fill_viridis(discrete = FALSE) + # sets heat map colors
  theme_classic() + # sets theme to classic
  theme(plot.title = element_text(hjust = .5)) # centers plot title

country_v_senti
View(country_v_senti)

ggsave(here("week_6","output","week_6_3rd_tidytuesday_african_language_sentiment.png"), # names and saves ggplot
       width = 11, height = 5) # adjust size of graph in inches