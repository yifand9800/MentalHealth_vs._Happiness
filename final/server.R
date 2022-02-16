source("map.R")
source("chart 2.R")
source("chart_3.R")
library(dplyr)
library(ggplot2)
library(plotly)
library(shiny)
options(stringsAsFactors = FALSE)

map.world$suicide_rate_per_100000_population <- as.numeric(
    map.world$suicide_rate_per_100000_population)

sr_range <- range(map.world$suicide_rate_per_100000_population, na.rm = T)

server <- function(input, output) {
    
#map  
    
    output$plot_data <- renderPlotly({
        p <- map.world %>%
            filter(suicide_rate_per_100000_population > input$suicide[1], 
                   suicide_rate_per_100000_population < input$suicide[2])
        map <- ggplot(p) + 
            geom_polygon(aes(x = long, y = lat, group = group,
                             fill = suicide_rate_per_100000_population,
                             location = Country), 
                         color = "black", size = 0.05) +
            labs(title = "Global Suicide rates vs Country", 
                 subtitle = "sources: https://www.kaggle.com/utkarshxy/who-worldhealth-statistics-2020-complete?select=crudeSuicideRates.csv",
                 fill = "suicide rate per 100,000 pop") +
            theme(
                axis.title.x = element_blank(),
                axis.title.y = element_blank(),
                panel.background = element_rect(fill = "azure"), 
                panel.border = element_rect(fill = NA))
        
        ggplotly(map)
    })
    
#scatterplot 
    
    output$scatter <- renderPlotly({
        
        x_choices <<- input$x_var
        
        y_choices <<- input$y_var
        
        my_plot <- ggplot(suicide_2016) +
            geom_point(mapping = aes_string(x = x_choices, y = y_choices)) +
            labs(title = "The relationship between beer consumption, suicide rate and happiness score")
        ggplotly(my_plot)
    })
    

#bar chart
    
    output$bar_chart <- renderPlotly({
        
        top_20 <- suicide_2016 %>%
            select(Country, Beer_PerCapita, Happiness.Score, suicide_rate_per_100000_population) %>%
            arrange(desc(Beer_PerCapita)) %>%
            na.omit() %>%
            head(20)
    
        chart <- ggplot(top_20) + 
            geom_col(mapping = aes_string(x = "Country" , y = input$top20_var),
                     fill = "#9ebcda")+
            coord_flip() + 
            theme_bw() +
            labs(
                title = "Top 20 Countries with the Most Beer Consumption, And Their Respective Suicide Rate and Happiness Score", 
                x = "Countries")
        
        ggplotly(chart)
    }) 
    
        
}
