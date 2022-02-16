source("Aggre_Table.R")
library("ggplot2")
library("tidyr")
library("tidyverse")
library("dplyr")

#create a chart with "suicide_2016" data set. 
#first, filter down to top 10 countries with the most beer consumption per capita. 
top_20 <- suicide_2016 %>%
  select(Country, Beer_PerCapita, Happiness.Score, suicide_rate_per_100000_population) %>%
  arrange(desc(Beer_PerCapita)) %>%
  na.omit() %>%
  head(20)

#render a horizontal bar chart of top 10 countries 
top_20_chart <- ggplot(top_20) +
  geom_col(mapping = aes(x = reorder(Country, Beer_PerCapita), y = Beer_PerCapita), fill = "#9ebcda") +
  coord_flip() + 
  theme_bw() +

#add title and axis labels
  labs(
    title = "The Top 20 Country with most Beer Consumption", 
    y = "Beern Consumption per Capita", 
    x = "Country")
  
  
  
  
  
