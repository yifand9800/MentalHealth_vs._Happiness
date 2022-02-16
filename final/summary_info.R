#Summary Information Script
suicide_rate <- read.csv("https://raw.githubusercontent.com/info201a-w21/project_AF/main/data/suicide%20rate.csv?token=ASMKXP6DHKSYGYDADA7KGKDAGTXAU")
WHR_2016 <- read.csv("https://raw.githubusercontent.com/info201a-w21/project_AF/main/data/WHR2020/2016.csv?token=ASMKXP4TURU76S7WXIB7363AGTWZS")
Alcohol_Consumption <- read_csv("https://raw.githubusercontent.com/info201a-w21/project_AF/main/data/HappinessAlcoholConsumption.csv?token=ASMKXPZIFESXAGIONVNMDYDAGT43Y")

summary_info <- list()
#How many country in suicide_rate dataset in 2016?
summary_info$Country <- suicide_rate %>%
  filter(X.1 == 2016) %>%
  select(X) %>%
  nrow()

#What's the top 1 happiness country in 2016?
summary_info$highest_country <- WHR_2016 %>%
  filter(Happiness.Rank == min(Happiness.Rank, na.rm = T)) %>%
  pull(Country)

#What's happiness score with the highest rank in 2016?
summary_info$highest_score <- WHR_2016 %>%
  filter(Happiness.Rank == min(Happiness.Rank, na.rm = T)) %>%
  pull(Happiness.Score)

#What's the beer consumption with the highest score in 2016?
summary_info$beer_with_highest_score <- Alcohol_Consumption %>%
  filter(HappinessScore == max(HappinessScore, na.rm = T)) %>%
  pull(Beer_PerCapita)

#What's the country with the lowest suicide rate in 2016?
summary_info$lowest_suicide_country <- suicide_rate %>%
  filter(Crude.suicide.rates..per.100.000.population. == 
           min(Crude.suicide.rates..per.100.000.population., na.rm = T)) %>%
  pull(X)


