library(dplyr)

mydata <- data.frame(x = 1:5, y = c("a", "b", "c", "d", "e"))

dput(mydata)

goulet <- structure(list(x = 1:5, y = c("a", "b", "c", "d", "e")), class = "data.frame", row.names = c(NA, 
                                                                                                       -5L))
