source("server.R")
library("htmltools")
library(shiny)
library(shinythemes)

#map input
map.world$suicide_rate_per_100000_population <- as.numeric(
    map.world$suicide_rate_per_100000_population)

sr_range <- range(map.world$suicide_rate_per_100000_population, na.rm = T)

sr_input <- sliderInput(
    inputId = "suicide",
    label = "Suicide Rate",
    min = sr_range[1],
    max = sr_range[2],
    value = sr_range
)

#Scatterplot input

x_input <- selectInput(
    inputId = "x_var",
    label = h3("Choose an x variable"),
    choices = c("Beer_PerCapita", "suicide_rate_per_100000_population", "Happiness.Score")
)

y_input <- selectInput(
    inputId = "y_var",
    label = h3("Choose an y variable"),
    choices = c("Beer_PerCapita", "suicide_rate_per_100000_population", "Happiness.Score")
)

#bar chart input 

bar_y_input <- selectInput(
    inputId = "top20_var",
    label = h3("Choose an x variable"),
    choices = c("Beer_PerCapita", "suicide_rate_per_100000_population", "Happiness.Score")
)

# introduction panel
intro_panel <- tabPanel("Introduction",
        img(src = "https://harvardmagazine.com/sites/default/files/img/article/1016/hires_pdf_page_06_image_0003.jpg"),
        h1("The purpose of the project"),
        p("The data of this project is from three datasets:",a("The happiness score and ranking" ,href = "https://www.kaggle.com/mathurinache/world-happiness-report"), ",", 
        a("suicide rate", href = "https://apps.who.int/gho/data/node.sdg.3-4-data?lang=en"), 
        "and", a("beer consumption", href ="https://www.kaggle.com/marcospessotto/happiness-and-alcohol-consumption"), "in 2016. 
          We want to see how the suciuide rate shows depends on different countries by using a map chart. 
          Also, we want to find the association between those three variables through a scatterplot. 
          Finally, we will analyze the suicide rate and happiness scores for countries with great amount of beer consumption using a bar chart. 
          We would like to explore if these countries would have relative high or low suicide rate and we would also like to see if they have relative high or low happiness score. 
          By doing this analysis, we can tell if they have a more consistent or diverse results when changing the variable.")
)                      

#map_panel 
map_panel <- tabPanel("Global Suicide rate",
    sidebarLayout(
        sidebarPanel(
            h1("Adjustable Graphical Parameters"),
            sr_input
        ),
        ### Main panel displays the map
        mainPanel(
            h2("Map"),
            plotlyOutput(outputId = "plot_data"),
            p("This map shows country with their suicide rates.
            We chose to visualize the relationship between location and suicide rates with a map. 
            The x-axis represents longititude and the y-axis represents latitude. 
            The colors of the map represent the geographic region the observation belongs. 
            You can choose the range of suicide rate to view by slider provided above the map.")
        )
    )
)


#plot_panel
plot_panel <- tabPanel("Relation Between Variables",
    sidebarLayout(
        sidebarPanel(
        h1("Choose x and y variable"),
            x_input,
            y_input
        ),
        mainPanel(
            h2("Scatterplot"),
            plotlyOutput(outputId = "scatter"),
            p("This scatterplot can show the relationship between three variable.
              From the select bar on the left side, you can choose one of the three variables to put inside the x-axis.
              Then, choose another variable for y-axis.
              Therefore, the relation between the two selected variables will be provided on the scatterpolt.")
        )
    )
)

#bar_panel
bar_panel <- tabPanel("Countries with Top20 Beer Consumption",
    sidebarLayout(
        sidebarPanel(
        h1("Adjustable Graphic Parameter"),
            bar_y_input
        ),
        mainPanel(
           h2("Bar Chart"),
            plotlyOutput(outputId = "bar_chart"),
            p("This bar chart shows three kinds of information about the top 20 countries with the most beer consumption: 
            the amount of beer consumed per capita, the suicide rate per 10000 countries and the happiness score. 
            The adjustable graphic parameter are used to change the x variable on the graph. 
            These charts are also interactive, and allows people to see the detailed numbers for each countries.")
                )
        )
)
    
    
#summary panel    
summ_panel <-  tabPanel("Conslusion",
        h1("Speicific takeaways from this project"),
        p("First, from the map which illustrates a relationship between country and its reported suicide rates. 
        We learned that countries located in Southern Asia and America, and Africa tend to report a lower suicide rate. 
        Countries located in Northern Asia tend to report a higher suicide rate, such as Russia, South Korea, and Japan are the top 3."),
        p("Then, the scatterplot chart shows a weak positive relationship between the beer consumption and happiness score.
        Drinking more beer may influecne the happiness score in each country.
        And the chart represents a negative association between suicide rate and happiness score. 
        Country who has a higher happiness score is represent a lower sucicide rate. 
        Also, we found there are no relationship between the suicide rate and beer consumption. 
        However, there are no evidence to support that higher beer consumption can effect suicide rate."),
        p("Moreover, the countries in this bar chart are stays the same, which are the top 20 countries with the most beer consumption. 
          Out of these 20 countries, Namibia have the highest beer consumption per capita, which is 376 liters, and its respected suicide rate is 8.7, which is relatively high compare to other countries from the list. 
          Also Namibia's happiness score is 4.5. For the bar chart on suicide rate, the data on the chart are highly diversified. 
          We can tell that high income countries such as Ireland, Canada, Netherland have really low suicide rate compare with other countries.")

)

#ui
ui<- shinyUI(
        navbarPage(
            theme = shinytheme("sandstone"),
    "Final Project",
    intro_panel,
    map_panel,
    plot_panel,
    bar_panel,
    summ_panel
    )
)
