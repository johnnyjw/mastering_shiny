# reactive expression getting rid of duplication of dataset <- line
library(shiny)
ui <- fluidPage(
  selectInput("dataset", label = "Dataset", choices = ls("package:datasets")),
  verbatimTextOutput("summary"),
  tableOutput("table")
)
server <- function(input, output, session) {
  #create a reactive expression
  dataset <- reactive({
    get(input$dataset, "package:datasets")
  })
  
  output$summary <- renderPrint({
    summary(dataset())
  })
  output$table <- renderTable({
    dataset()
  })
}
shinyApp(ui, server)