---
  Title: "Daily Exercise 07"
Author: "Johann Ayala-Vargas"
Date: "08-12-2020"
Purpose:
  ---
  
  url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv'


covid = read_csv(url)
head(covid, 5)

region = data.frame(state = state.name, region = state.region)
head(region)



library(tidyverse)

#Question 1: Make a faceted plot of the cumulative cases & deaths by USA region. Your x axis should be the date and the y axis value/count. To do this you will need to join and pivot the COVID-19 data.

covid_by_region = covid %>%
  right_join(region, by = "state") %>%
  group_by(region, date) %>%
  summarize(cases = sum(cases), deaths = sum(deaths)) %>%
  pivot_longer(cols = c('cases', 'deaths'))

ggplot(covid_by_region, aes(x = date, y = value)) +
  geom_line(aes(col = region)) +
  facet_grid(name~region, scale = "free_y") +
  labs(Title = "Cumulative Cases and Deaths by Region", x = "Date", y = "Daily Cumulative Counts", caption = "Daily Exercise 7")

ggsave(covid_by_region, file="img/CumulativeCasesandDeathsbyRegion.png")



