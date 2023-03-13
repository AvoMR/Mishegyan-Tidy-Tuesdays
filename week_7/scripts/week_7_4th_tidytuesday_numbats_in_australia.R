### My fourth tidytuesday of week 7 ####
### Created by: Avetis Mishegyan #############
### Created on: 2023-03-12 ####################


#### Load Libraries ######
library(tidyverse)
library(here)
library(tidytuesdayR)
library(viridis) # for viridis color palette
library(ggmap) # for ggmaps


### Load data ######
register_google(key = "Place API Key Here", write = TRUE) # use your own API
# IMPORTANT don't put your key to github!! I usually save mine in a text file and import it each time
# Setting write = TRUE will write the API key to your R environment so that you do not have to re register it each time

tuesdata <- tidytuesdayR::tt_load('2023-03-07') # reads in data using the tidytuesdayR package

numbats <- tuesdata$numbats
View(numbats) # view opens a new window to view the data
glimpse(numbats) # glimpse allows us to inspect the data


### Data Analysis ######
numbats_map <- numbats %>%
  filter(scientificName == "Myrmecobius fasciatus rufus") %>% # filters data that contains only 1 bat species
  group_by(decimalLongitude, decimalLatitude, scientificName) %>% # groups data by long, lat, and bat species
  count(scientificName) %>% # counts number of bat species
  drop_na() # filters out everything that is not a complete row
View(numbats_map)

Australia <- get_map("Australia", zoom = 5, maptype = "satellite") # gets a base map from Google Maps
ggmap(Australia) + # plots map
  geom_point(data = numbats_map, # plots points
             aes(x = decimalLongitude,
                 y = decimalLatitude,
                 color = n)) +
  labs(x = "Longitude",
       y = "Latitude",
       color = "Bat Count",
       title = "Number of Myrmecobius fasciatus rufus 
       Bats Found in Australia") +
  scale_color_viridis_c() + # sets point map colors
  theme(plot.title = element_text(hjust = .5)) # centers plot title

ggsave(here("week_7","output","week_7_4th_tidytuesday_numbats_in_australia.png"), # names and saves ggplot
       width = 6, height = 6) # adjust size of graph in inches