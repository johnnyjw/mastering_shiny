library(shiny)
library(dplyr, warn.conflicts = FALSE)

sales <- vroom::vroom(
  "/home/bceuser/whartoj2/Mastering_Shiny/sales-dashboard/sales_data_sample.csv",
  col_types = list(),
  na = ""
)

ui <- fluidPage(
  selectInput("dataset", "Choose a dataset", c("pressure", "cars")),
  selectInput("column", "Choose column", character(0)),
  verbatimTextOutput("summary")
)

server <- function(input, output, session) {
  dataset <- reactive(get(input$dataset, "package:datasets"))
  
  observeEvent(input$dataset, {
    updateSelectInput(inputId = "column", choices = names(dataset()))
  })
  
  output$summary <- renderPrint({
    summary(dataset()[[input$column]])
  })
}

shinyApp(ui, server)