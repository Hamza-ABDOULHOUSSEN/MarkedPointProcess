library ( shiny )
library(ggplot2)

shinyServer ( function (input , output ) {
    
    output$plot_point_pattern <- renderPlot({
        switch(
          input$database_index,
          "amacrine" = plot(amacrine, markscale=1),
          "anemones" = plot(anemones, markscale=1)
        )
        
      
    })
})
