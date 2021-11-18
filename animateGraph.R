library(shiny)
library(ggplot2)
library(gapminder)
library(dplyr)
library(rsconnect)
library(ggpmisc)

ui <- fluidPage(
  titlePanel(title=h4("Life Expectancy versus GDP per Capita", align="center")),
  sidebarPanel( 
    sliderInput("yearValue", "Year:",min = 1952, max = 2002,step=5,value=1952, sep = "", animate=TRUE)),
  mainPanel(plotOutput("plot")))

server <- function(input,output){
  yearval <- reactive({
    test <- input$yearValue
  })
  
  output$plot<-renderPlot({
    gapminder %>%
      filter(year == yearval()) %>%
      ggplot(gapminder, mapping = aes(x = gdpPercap, y = lifeExp, size = pop, colour = continent)) +
      geom_point(alpha = 0.7, show.legend = FALSE) +
      geom_smooth(method="lm",se = FALSE) +
      stat_poly_eq(formula =  y ~ x, 
                   aes(label = paste(..eq.label.., ..rr.label.., sep = "~~~")), 
                   parse = TRUE, label.y = "bottom", label.x = "right") + 
      scale_size(range = 2) +
      scale_x_log10() + 
      facet_wrap(~continent) +
      xlab("GDP per Capita") +
      ylab("Life Expectancy") 
    }, height = 400,width = 600)
  }

shinyApp(ui, server)

