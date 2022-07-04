library(shiny)
library(vroom)
library(tidyverse)

setwd("../..")
injuries <- vroom::vroom("neiss/injuries.tsv.gz")
products <- vroom::vroom("neiss/products.tsv")
population <- vroom::vroom("neiss/population.tsv")
prod_codes <- setNames(products$prod_code, products$title)

count_top <- function(df, var, n = 5) {
  df %>% 
    mutate({{ var }} := fct_lump(fct_infreq({{ var}}), n = n)) %>% 
    group_by({{ var }}) %>% 
    summarise(n = as.integer(sum(weight)))
    
}

ui <- fluidPage(
  fluidRow(
    column(8,
           selectInput("code", "Product", 
                       choices = setNames(products$prod_code, products$title),
                       width = "100%")
           ),
           column(2, selectInput("y", "Y axis", c("rate", "count"))),
           column(3, numericInput("n", "How many Rows?", value=5))
    
  ),
  fluidRow(
    column(4, tableOutput("diag")),
    column(4, tableOutput("body_part")),
    column(4, tableOutput("location"))
  ),
  fluidRow(
    column(12, plotOutput("age_sex"))
  ),
  fluidRow(
    column(2, actionButton("add1", "Forward")),
    column(3, actionButton("subtract1", "Backward")),
    column(10, textOutput("narrative"))
  )
)

server <- function(input, output, server) {
  selected <- reactive(injuries %>% filter(prod_code == input$code))
  
  output$diag <- renderTable(count_top(selected(), diag, input$n), width = "100%")
  
  output$body_part <- renderTable(count_top(selected(), body_part, input$n), width = "100%")
  
  output$location <- renderTable(count_top(selected(), location, input$n), width = "100%")
  
  counter <- reactiveValues(countervalue = 1) # Defining & initializing the reactiveValues object
  observeEvent(input$add1, {
  counter$countervalue <- counter$countervalue + 1   # if  the add button is clicked, increment the value by 1 and update it
})
  observeEvent(input$subtract1, {
  counter$countervalue <- counter$countervalue - 1   # if  the subtract button is clicked, reduce the value by 1 and update it
})
  
  summary <- reactive({
    selected() %>% 
      count(age, sex, wt = weight) %>% 
      left_join(population, by = c("age", "sex")) %>% 
      mutate(rate = n / population * 1e4)
  })
  
  output$age_sex <- renderPlot({
    if (input$y == "count") {
    summary() %>% 
      ggplot(aes(age, n, colour = sex)) +
      geom_line() +
      labs(y = "Estimated number of injuries")
    } else {
    summary() %>% 
      ggplot(aes(age, rate, colour = sex)) +
      geom_line(na.rm = TRUE) +
      labs(y = "Injuries per 10,000 people")
     }
  }, res = 96)
  
  narrative_sample <- reactive({
    selected()$narrative[counter$countervalue]
      
  })
  
  output$narrative <- renderText(narrative_sample())
  

}

shinyApp(ui, server)