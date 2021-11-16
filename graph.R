library(ipumsr)
library("haven")
library(dplyr)
library(tidyverse)

ddi <- read_ipums_ddi("nhis_00002.xml")
data <- read_ipums_micro(ddi)

data$INCFAM07ON <- haven::as_factor(data$DGRDG)
data$HRSLEEP <- haven::as_factor(data$SALARY)

data %>% mutate(INCFAM07ON = case_when(INCFAM07ON == 10 ~ "$0-$49,999",
                                       INCFAM07ON == 11 ~ "$0-$34,999",
                                       INCFAM07ON == 12 ~ "$35,000-$49,999",
                                       INCFAM07ON == 20 ~ "$50,000+",
                                       INCFAM07ON == 21 ~ "$50,000-$99,999",
                                       INCFAM07ON == 22 ~ "$50,000-$74,999",
                                       INCFAM07ON == 23 ~ "$75,000-$99,999",
                                       INCFAM07ON == 24 ~ "$100,000+",
                                       TRUE ~ as.character(INCFAM07ON)))

view(data)

data %>%
  filter(HRSLEEP > 0) %>%
  filter(HRSLEEP < 25) %>%
  filter(INCFAM07ON < 96) %>%
  mutate(INCFAM07ON = case_when(INCFAM07ON == 10 ~ "$0-$49,999",
                                INCFAM07ON == 11 ~ "$0-$34,999",
                                INCFAM07ON == 12 ~ "$35,000-$49,999",
                                INCFAM07ON == 20 ~ "$50,000+",
                                INCFAM07ON == 21 ~ "$50,000-$99,999",
                                INCFAM07ON == 22 ~ "$50,000-$74,999",
                                INCFAM07ON == 23 ~ "$75,000-$99,999",
                                INCFAM07ON == 24 ~ "$100,000+",
                                TRUE ~ as.character(INCFAM07ON))) %>%
  ggplot(data, mapping = aes(INCFAM07ON, HRSLEEP)) + 
  geom_point()
