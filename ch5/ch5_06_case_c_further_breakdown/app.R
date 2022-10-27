
library(shiny)

datetime <- Sys.time() + (86400 * 0:10)

ui <- fluidPage(
  sliderInput("slider",
              "Select Range:",
              min = min(datetime),
              max = max(datetime),
              value = c(min, max)
              ),
  verbatimTextOutput("breaks")
)
server <- function(input, output, session) {

  brks <- reactive({
    req(input$slider)
    seq(input$slider[1], input$slider[2], length.out = 10)
  })
  
  output$breaks <- brks
}
shinyApp(ui, server)