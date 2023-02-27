### My second tidytuesday in week 5 ####
### Created by: Avetis Mishegyan #############
### Created on: 2023-02-21 ####################


#### Load Libraries ######
library(tidyverse)
library(here)
library(tidytuesdayR)
library(alphonse)
library(ggridges)


### Load data ######
tuesdata <- tidytuesdayR::tt_load('2023-02-21') # reads in data using the tidytuesdayR package

bob_ross <- tuesdata$bob_ross
glimpse(bob_ross) # glimpse allows us to inspect the data
View(bob_ross) # view opens a new window to view the data


### Data Analysis ######
bob_ross %>%
  drop_na() %>% # drops all NA's
  mutate(season = as_factor(season)) %>%  # converts season from a continues value to a discrete factor
  filter(season %in% c("1", "2", "3", "4")) %>% # filters by seasons 1 to 4
ggplot(mapping = aes(x = num_colors,
                     fill = season)) +
  geom_histogram(bins = 15) + # sets x-axis interval max to 15
  facet_wrap(~season, # separates each season into its own graph
             scales = "free_y") + # frees y-axis scale
  labs(x = "Color Used",
       y = "# of Times Used",
       fill = "Season",
       title = "Number of Times Bob Ross Used a Specific Color per Season") +
  theme(plot.title = element_text(hjust = .5)) + # centers plot title
  theme_bw() + # sets theme to classic dark-on-light
  scale_fill_manual(values = alphonse("onepiece")) # sets One Piece color palette

ggsave(here("week_5","output","week_5_2nd_tidytuesday_bob_ross.png"), # names and saves ggplot
       width = 8, height = 5) # adjust size of graph in inches

# Unused assets
#bob_ross %>%
#  drop_na() %>%
#  mutate(season = as_factor(season)) %>%
#  ggplot() +
#  geom_density_ridges(mapping = aes(x = num_colors,
#                                    y = season))
