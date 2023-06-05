library(shiny)
library(reactable)
library(tidyverse)
library(conflicted)
library(janitor)
library(markdown)

the_data <- as_tibble(datasets::Titanic)
the_data <- uncount(the_data, n)

ui <- fluidPage(
  includeMarkdown("page1.md"),
  reactableOutput("table"),
  tableOutput("table2")
)

server <- function(input, output, session) {
  output$table <- renderReactable({
    the_data %>% 
      reactable()
  })
  output$table2 <- renderTable({
    the_data %>% 
      tabyl(Class) %>% 
      adorn_rounding(2)
    
    
  })
  
}
shinyApp(ui, server)
