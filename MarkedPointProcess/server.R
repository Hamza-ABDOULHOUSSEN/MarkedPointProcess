library ( shiny )
library(ggplot2)
library(markdown)

shinyServer ( function (input , output ) {
  
    #output$database_index <- input$database_index
    
    output$plot_point_pattern <- renderPlot({
        switch(
          input$database_index,
          "amacrine" = plot(amacrine, markscale=1),
          "anemones" = plot(anemones, markscale=1)
        )
        
      
    })
})
