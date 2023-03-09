library(tidyverse)
library(shinythemes)
library(shiny)
library(DT)
library(here)

load(here::here("sensitive", "both.RData"))
source(here::here("R", "mod_employment.R"))


ui <- fluidPage(theme = shinytheme("yeti"),
                titlePanel("scratch holds app"),
                tabsetPanel(
                    tabPanel("Washington County", mod_employment_ui("wa", both)), 
                    tabPanel("Utah", mod_employment_ui("ut", both)),
                    tabPanel("United States", mod_employment_ui("us", both))
                )
)
server <- function(input, output, session) {
    
   mod_employment_server("wa", both, "_wa")
   mod_employment_server("ut", both, "_ut")
   mod_employment_server("us", both, "_us")
   
}
# Run the application
shinyApp(ui = ui, server = server)