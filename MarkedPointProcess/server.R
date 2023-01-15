library ( shiny )
library(ggplot2)
library(markdown)

shinyServer ( function (input , output ) {
  
  output$data_about <- renderText({
    data = input$database_index
    includeMarkdown(paste("data/", data, ".md", sep=""))
  })
    
  output$plot_point_pattern <- renderPlot({
      switch(
        input$database_index,
        "amacrine" = plot(amacrine, markscale=1),
        "anemones" = plot(anemones, markscale=1)
      )
      
    
  })
})
