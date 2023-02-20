### My fist tidytuesday of week 4 ####
### Created by: Avetis Mishegyan #############
### Created on: 2023-02-19 ####################


#### Load Libraries ######
library(tidyverse)
library(here)
library(tidytuesdayR)


### Load data ######
tuesdata <- tidytuesdayR::tt_load('2023-01-31') # reads in data using the tidytuesdayR package

cats_uk <- tuesdata$cats_uk
View(cats_uk) # view opens a new window to view the data
glimpse(cats_uk) # glimpse allows us to inspect the data

cats_uk_reference <- tuesdata$cats_uk_reference
View(cats_uk_reference)
glimpse(cats_uk_reference)

### Data Analysis ######
cat_ref <- cats_uk_reference %>%
  drop_na() %>% # filters out everything that is not a complete row
  ggplot(mapping = aes(x = food_wet,
                       y = food_dry,
                       fill = prey_p_month)) +
  geom_tile() + # heat map function
  labs(x = "If Fed Wet Food",
       y = "If Fed Dry Food",
       fill = "# Prey/Month",
       title = "Diet Effects on # of Prey Caught by UK Cats") +
  theme(plot.title = element_text(hjust = .5)) + # centers plot title
  theme_classic() +
  scale_fill_gradient(low = "white", high = "blue") # sets heat map colors

cat_ref

ggsave(here("week_4","output","week_4_1st_tidytuesday_pet_cats_uk.png"),
       width = 5, height = 5) # adjust size of graph in inches