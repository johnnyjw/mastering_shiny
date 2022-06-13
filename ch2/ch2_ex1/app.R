library(shiny)

ui <- fluidPage(
  # ex 1
  textInput("spacy", "", value="Your Name"),
  # ex 2
  sliderInput("datey", "When should we deliver?",
              value = as.Date('2020-09-17', "%Y-%m-%d"),
              min =as.Date('2020-09-16', "%Y-%m-%d"),
              max = as.Date('2020-09-23', "%Y-%m-%d"),
              timeFormat = "%F"),
  # ex 3
  sliderInput("animy", "Pick a lucky number",
              value = 0,
              min = 0,
              max = 100,
              step = 5,
              animate = TRUE),
  # ex 4
  selectInput("state", "Choose a state:",
              list(`East Coast` = list("NY", "NJ", "CT"),
                   `West Coast` = list("WA", "OR", "CA"),
                   `Midwest` = list("MN", "WI", "IA"))
  )
)

server <- function(input, output, session) {

}

shinyApp(ui, server)