library(shiny)

ui <- fluidPage(
  fileInput("upload", NULL),
  actionButton("click", "Click me!"),
  actionButton("drink", "Drink me!", icon = icon("cocktail")),
  fluidRow(
    actionButton("click2", "Click me!", class = "btn-danger"),
    actionButton("drink2", "Drink me!", class = "btn-lg btn-success")
  ),
  fluidRow(
    actionButton("eat", "Eat me!", class = "btn-block")
  )
)

server <- function(input, output, session) {

}

shinyApp(ui, server)