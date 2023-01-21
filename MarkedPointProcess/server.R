library ( shiny )
library(ggplot2)
library(markdown)

shinyServer ( function (input , output, session) {
  
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
  
  find_nearest_neighbour <- function(data, p) {
    distance <- function(data, p1, p2) {
      sqrt( (data$x[p1]-data$x[p2])^2 + (data$y[p1]-data$y[p2])^2 )
    }
    
    nearest_neighbour = 1
    if (p == 1) {
      nearest_neighbour = 2
    }
    min_dist = distance(data, p, nearest_neighbour)
    for (k in 1:data$n) {
      if (k != p) {
        d = distance(data, p, k)
        if (d < min_dist) {
          nearest_neighbour = k
          min_dist = d
        }
      }
    }
    
    nearest_neighbour
  }
  
  get_delta_x <- function(data, p1, p2) {
    abs(data$x[p1] - data$x[p2])
  }
  
  get_delta_y <- function(data, p1, p2) {
    abs(data$y[p1] - data$y[p2])
  }
  
  get_orientation_x <- function(data, p) {
    nearest_neighbour = find_nearest_neighbour(data, p)
    get_delta_x(data, p, nearest_neighbour)
  }
  
  get_orientation_y <- function(data, p) {
    nearest_neighbour = find_nearest_neighbour(data, p)
    get_delta_y(data, p, nearest_neighbour)
  }
  
  complete_orientation <- function(data) {
    delta_x = c()
    delta_y = c()
    for (p in 1:data$n) {
      delta_x = c(delta_x, get_orientation_x(data, p))
      delta_y = c(delta_y, get_orientation_y(data, p))
    }
    
    dataframe = data.frame(x=data$x, y=data$y, marks=data$marks, delta_x=delta_x, delta_y=delta_y)
    
    dataframe
  }
  
  extract_mark_labels <- function(marks) {
    extracted_labels = c()
    k = 0
    for (i in marks) {
      if (!i %in% extracted_labels) {
        extracted_labels = c(extracted_labels, i)
      }
    }
    extracted_labels
  }
  
  ### OBSERVE ###
  
  database_index = reactive({input$database_index})
  
  data = reactive({get_data(database_index())})
  
  extract_mark_labels_list = reactive({sort(extract_mark_labels(data()$marks), decreasing = FALSE)})
  
  observe(
    updateSelectInput(session, "mark_selected",
                      label = "marks",
                      choices = extract_mark_labels_list(),
                      selected = extract_mark_labels_list()[1]
    )
  )
  observe(
    updateSelectInput(session, "mark_selected_i",
                      label = "marks",
                      choices = extract_mark_labels_list(),
                      selected = extract_mark_labels_list()[1]
    )
  )
  observe(
    updateSelectInput(session, "mark_selected_j",
                      label = "marks",
                      choices = extract_mark_labels_list(),
                      selected = extract_mark_labels_list()[1]
    )
  )
  
  ### OUTPUT ###
  
  output$data_about <- renderText({
    database_index = input$database_index
    includeMarkdown(paste("data/", database_index, ".md", sep=""))
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
    ggplot(dataframe, aes(x, y)) + geom_point(aes(colour = factor(marks))) + ggtitle(database_index)
  })
  
  output$plot_filter <- renderPlot({
    database_index = input$database_index
    data = get_data(database_index)
    mark = input$mark_selected
    plot(data[data$marks == mark], markscale=1, main=paste(database_index, 'for mark', mark))
  })
  
  output$plot_FGJK_F <- renderPlot({
    database_index = input$database_index
    data = get_data(database_index)
    plot(Fest(data), main=database_index)
  })
  
  output$plot_FGJK_G <- renderPlot({
    database_index = input$database_index
    data = get_data(database_index)
    plot(Gest(data), main=database_index)
  })
  
  output$plot_FGJK_J <- renderPlot({
    database_index = input$database_index
    data = get_data(database_index)
    plot(Jest(data), main=database_index)
  })
  
  output$plot_FGJK_K <- renderPlot({
    database_index = input$database_index
    data = get_data(database_index)
    plot(Kest(data), main=database_index)
  })
  
  output$plot_orientation <- renderPlot({
    database_index = input$database_index
    data = get_data(database_index)
    
    dataframe = complete_orientation(data)
    
    ggplot(dataframe, aes(x, y)) +
      geom_segment(aes(xend = x + delta_x, yend = y + delta_y),
                   arrow = arrow(length = unit(0.1,"cm"))) +
      geom_point() + labs(title=database_index)
  })
  
  
  
})
