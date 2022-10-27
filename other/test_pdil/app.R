suppressPackageStartupMessages({
   library(shiny)
   library(ggplot2)
   library(tidyverse)
   library(RDCH.snowflake)
})

RDCH.snowflake::connect_snowflake(
  server = "roche_pd.eu-central-1.snowflakecomputing.com",
  user = Sys.getenv("PDG_userid"),
  password  = Sys.getenv("PDG_pwd"),
  role = "GLOAZUSFPDG_PDG_READ",
  db = "PDG_PROD",
  warehouse = "PDG_WH",
  global = TRUE,
  type = "ODBC"
)

# study and site metrics
study <- query_snowflake("select STUDY_NUMBER,ACRONYM, THERAPEUTIC_AREA_PDG, INDICATION, PRIMARY_PRODUCT_DESC, PDG_CODAC
                                from \"PDG_PROD\".\"SITESEL_DATA\".\"DM_D_SS_STUDY\";")


dta <- study %>% select(THERAPEUTIC_AREA_PDG) %>% 
  unique() %>% 
  filter(!is.na(THERAPEUTIC_AREA_PDG))
dta <- dta$THERAPEUTIC_AREA_PDG




ui <- fluidPage(
  fluidRow(
    column(3,

           selectInput("dta", "Select DTA:", dta)
     ),
    column(9,
           dataTableOutput("study")
           )
  )
)

server <- function(input, output, server) {
  

  
  
  output$study <- renderDataTable({
    study %>% filter(THERAPEUTIC_AREA_PDG == input$dta) 
    
    }, options = list(pageLength = 5))
  

}

shinyApp(ui, server)