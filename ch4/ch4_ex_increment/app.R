library(shiny)


ui <- fluidPage(
  
  # Application title
  titlePanel("Counter"),
  
  
  # Show button and text
  mainPanel(
    actionButton("add1", "+ 1"),
    actionButton("subtract1", "- 1"),
    br(),
    textOutput("count")
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  counter <- reactiveValues(countervalue = 0) # Defining & initializing the reactiveValues object
  
  observeEvent(input$add1, {
    counter$countervalue <- counter$countervalue + 1   # if  the add button is clicked, increment the value by 1 and update it
  })
  
  observeEvent(input$subtract1, {
    counter$countervalue <- counter$countervalue - 1   # if  the subtract button is clicked, reduce the value by 1 and update it
  })
  
  output$count <- renderText({
    paste("Counter Value is ", counter$countervalue)   # print the latest value stored in the reactiveValues object
  })
}

shinyApp(ui, server)