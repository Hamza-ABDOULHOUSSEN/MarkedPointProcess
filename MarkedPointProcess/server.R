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
  
  convert_to_dataframe <- function(data) {
    data.frame(x=data$x, y=data$y, marks=data$marks)
  }
  
  output$data_about <- renderText({
    data = input$database_index
    includeMarkdown(paste("data/", data, ".md", sep=""))
  })
    
  output$plot_point_pattern <- renderPlot({
      database_index = input$database_index
      data = get_data(database_index)
      plot(data, markscale=1, main=database_index)
  })
  
  output$plot_point_pattern_ggplot <- renderPlot({
    database_index = input$database_index
    data = get_data(database_index)
    dataframe = convert_to_dataframe(data)
    # add title / main
    ggplot(dataframe, aes(x, y)) + geom_point(aes(colour = factor(marks)))
  })
  
})
