df <- data.frame(x = 1, y = 2)
input <- list(var = "x", min = 0)

df %>% filter(.data[[input$var]] > input$min)


# doesn't work
df <- data.frame(x = 1, y = 2, input = 3)
df %>% filter(.data[[input$var]] > input$min)


# fix
df <- data.frame(x = 1, y = 2, input = 3)
df %>% filter(.data[[input$var]] > .env$input$min)
