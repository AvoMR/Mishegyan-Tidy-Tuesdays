### My fifth tidytuesday of week 8 ####
### Created by: Avetis Mishegyan #############
### Created on: 2023-03-19 ####################


#### Load Libraries ######
library(tidyverse)
library(here)
library(tidytuesdayR)
library(alphonse) # for alphonse color palette


### Load data ######
tuesdata <- tidytuesdayR::tt_load('2023-03-14') # reads in data using the tidytuesdayR package

drugs <- tuesdata$drugs
View(drugs) # view opens a new window to view the data
glimpse(drugs) # glimpse allows us to inspect the data


### Data Analysis ######
drug_assessment <- drugs %>%
  pivot_longer(cols = conditional_approval:accelerated_assessment, # pivots data into long format into new columns
               names_to = "assessment_type",
               values_to = "assessment") %>%
  mutate(assessment_type = case_when(assessment_type == "accelerated_assessment" ~ "Accelerated Assessment", # renames assesment type
                               assessment_type == "conditional_approval" ~ "Conditional Approval",
                               assessment_type == "exceptional_circumstances" ~ "Exceptional Circumstances")) %>%
  group_by(category, assessment_type) %>% # groups data by category and assessment type
  filter(assessment == "TRUE") %>% # filters data that contains only TRUE values
  count(assessment_type) # counts number of each drug assessment type
View(drug_assessment)

drug_assessment_plot <- drug_assessment %>%
  ggplot(mapping = aes(x = assessment_type,
                       y = n,
                       fill = assessment_type)) +
  geom_bar(position = "dodge", # bar graph function
           stat = "identity") +
  labs(x = "Assessment Type",
       y = "Count",
       color = "Count",
       title = "Assessment of European Drug Authorisations") +
  scale_fill_manual(values = alphonse("mhadeku")) + # sets bar graph colors
  facet_wrap(~category) + # separates out graph by categories
  theme_bw() + # sets theme to black white
  theme(legend.position = "none") + # removes legend
  theme(plot.title = element_text(hjust = .5)) # centers plot title
drug_assessment_plot

ggsave(here("week_8","output","week_8_5th_tidytuesday_european_drug_development.png"), # names and saves ggplot
       width = 10, height = 5) # adjust size of graph in inches