library(shiny)

mod_employment_ui <- function(id, input_df){
  ns <- NS(id) 
  
  
  #fluidPage(
  #titlePanel("scratch holds app"),
  fluidRow(
    column(4,
           selectInput(ns("title"),
                       "Areas of Study:", unique(as.character(input_df$title)))
    ),
    DT::dataTableOutput(ns("mytable"))
  )
}  

mod_employment_server <- function(id, input_df, x) {
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    x <- rlang::enquo(x)
    
    output$mytable <- DT::renderDataTable({
      DT::datatable({
        data1 <- input_df %>%
        select(1:7, ends_with(!!x)) %>% 
        filter(title == input$title) %>% 
          transpose()
        
        data <- data.frame(unlist(data1))

      })
    })    
  })
}