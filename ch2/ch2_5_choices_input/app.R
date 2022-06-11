library(shiny)

animals <- c("dog", "cat", "mouse", "bird", "other", "I hate animals")
ui <- fluidPage(
  selectInput("state", "What's your favourite state?", state.name),
  radioButtons("animal", "What's your favourite animal?", animals),
  radioButtons("rb", "Choose one:",
               choiceNames=  list(
                 icon("angry"),
                 icon("smile"),
                 icon("sad-tear")
               ),
               choiceValues = list("angry", "happy", "sad")),
  selectInput("st_multi", "What are your favourite states?", state.name,
              multiple=TRUE),
  checkboxGroupInput("animals", "What animals do you like?", animals),
  checkboxInput("cleanup", "Clean up?", value = TRUE),
  checkboxInput("shutdown", "Shutdown?")
)

server <- function(input, output, session) {

}

shinyApp(ui, server)