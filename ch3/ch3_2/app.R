library(shiny)


ui <- fluidPage(
  textInput("name", "What's your name?"),
  textOutput("greeting")
)
server <- function(input, output, session) {
  # lines of execution order flipped but it doesn't matter
  output$greeting <- renderText(string())
  string <- reactive(paste0("Hello ", input$name, "!"))
}

shinyApp(ui, server)