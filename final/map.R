source("Aggre_Table.R")
library(ggplot2)
library(maps)
library(mapproj)
library(dplyr)
library(tidyr)

#inspect 
as.factor(suicide_2016$Country) %>% levels()
#recode names
suicide_2016$Country <- recode(suicide_2016$Country,
                               "United States of America" = "USA",
                               "Republic of Korea" = "South Korea",
                               "Democratic People's Republic of Korea" = "North Korea",
                               "Viet Nam" = "Vietnam",
                               "Venezuela (Bolivarian Republic of)" = "Venezuela",
                               "United Republic of Tanzania" = "Tanzania",
                               "United Kingdom of Great Britain and Northern Ireland" = "UK",
                               "Trinidad and Tobago" = "Trinidad",
                               "Syrian Arab Republic" = "Syria",
                               "Saint Vincent and the Grenadines" = "Saint Vincent",
                               "Russian Federation" = "Russia",
                               "Republic of Moldova" = "Moldova",
                               "North Macedonia" = "Macedonia",
                               "Micronesia (Federated States of)" = "Micronesia",
                               "Lao People's Democratic Republic" = "Laos",
                               "Iran (Islamic Republic of)" = "Iran",
                               "Czechia" = "Czech Republic",
                               "Côte d'Ivoire" = "Ivory Coast",
                               "Congo" = "Republic of Congo",
                               "Cabo Verde" = "Cape Verde",
                               "Brunei Darussalam" = "Brunei",
                               "Bolivia (Plurinational State of)" = "Bolivia",
                               "Antigua and Barbuda" = "Antigua"
                               )
#change discrete to continuous
suicide_2016$suicide_rate_per_100000_population <- as.numeric(as.character(
  suicide_2016$suicide_rate_per_100000_population))
#join charts
map.world <- map_data("world") %>%
  rename(Country = region) %>%
  left_join(suicide_2016, by="Country")
#create world map
map <- ggplot(map.world) + 
  geom_polygon(aes(x = long, y = lat, group = group,
  fill = suicide_rate_per_100000_population), color = "black", size = 0.05)+
  labs(title = "Global Suicide rates", 
       subtitle = "sources:https://www.kaggle.com/utkarshxy/who-worldhealth-statistics-2020-complete?select=crudeSuicideRates.csv",
       fill = "suicide rate per 100,000 pop") +
  scale_fill_viridis_c(option = "plasma") + 
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.background = element_rect(fill = "azure"), 
    panel.border = element_rect(fill = NA))
