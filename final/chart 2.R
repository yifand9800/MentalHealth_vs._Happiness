source("Aggre_Table.R")
library("ggplot2") 

scottorplot_beer_happiness <- ggplot(data = suicide_2016) +
  geom_point(mapping = aes(x = Happiness.Score , y = Beer_PerCapita)) +
  labs( x = "Average happiness Score", y = "Liter of Beer per capita", 
        title = "Realtionship Between Happiness Score and Beer Consumption")

              