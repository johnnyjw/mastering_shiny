library(shiny)

ui <- fluidPage(
  verbatimTextOutput("pr1"),
  textOutput("te1"),
  verbatimTextOutput("pr2"),
  textOutput("te2")
)

server <- function(input, output, session) {
  output$pr1 <- renderPrint(summary(mtcars))
  output$te1 <- renderText("Good morning!")
  output$pr2 <- renderPrint(t.test(1:5, 2:6))
  output$te2 <- renderText(str(lm(mpg ~ wt, data = mtcars)))
  
}

shinyApp(ui, server)