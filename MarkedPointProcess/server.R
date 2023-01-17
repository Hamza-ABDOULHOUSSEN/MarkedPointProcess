library ( shiny )
library(ggplot2)
library(markdown)

shinyServer ( function (input , output ) {
  
  get_data <- function(database_index) {
    switch(
      database_index,
      "amacrine" = amacrine,
      "anemones" = anemones,
      "ants" = ants,
      "betacells" = betacells,
      "bramclecanes" = bramclecanes
    )
  }
  
  output$data_about <- renderText({
    data = input$database_index
    includeMarkdown(paste("data/", data, ".md", sep=""))
  })
    
  output$plot_point_pattern <- renderPlot({
      database_index = input$database_index
      data = get_data(database_index)
      print(data)
      plot(data, markscale=1, main=database_index)
  })
  
})
