library(shiny)
library(shinydashboard)
library(markdown)
library(shinyjs)
library(spatstat)

ui <- shinyUI(dashboardPage(
  dashboardHeader(title = "Marked Point Process"),
  
  ## DASHBOARD SIDEBAR
  dashboardSidebar(
    sidebarMenu(
      menuItem("Home", tabName="home", icon=icon("home")),
      menuItem("Plot", tabName="plot", icon=icon("bar-chart-o")),
      menuItem("Histogram", tabName="histogram", icon=icon("bar-chart-o")),
      menuItem("Density", tabName="density_tab", icon=icon("bar-chart-o")),
      menuItem("F, G, J and K functions", tabName="plotFGJK", icon=icon("bar-chart-o")),
      menuItem("Orientation Analysis", tabName="plotOrientation", icon=icon("bar-chart-o")),
      menuItem("Mark Filter", tabName="markFilter", icon=icon("bar-chart-o")),
      menuItem("K-means", tabName="k_means", icon=icon("bar-chart-o"))
    )
  ),
  
  ## DASHBOARD BODY
  dashboardBody(
    useShinyjs(),
    tags$head(tags$style(HTML('.content-wrapper { background-color: #4e4e4e; } ' ))),
    
    includeCSS("css/style.css"),
    
    tabItems(
    
        ## HOME PAGE
        tabItem(tabName = "home",
                h1("Marked Point Process"),
                
                fluidRow(
                  
                  box(
                  width = 12,
                  title = "Load data", status = "primary", solidHeader = TRUE,
                  collapsible = TRUE,
                  selectInput("database_index", h3("Data Selection"),
                              choices = list(
                                "amacrine" = "amacrine",
                                "anemones" = "anemones", 
                                "ants" = "ants",
                                "betacells" = "betacells",
                                "bramclecanes" = "bramclecanes"),
                              selected = 1)
                  ),
                ),
                
                HTML("<p></p>"),
                
                fluidRow(
                  box(
                    width = 12,
                    title = "about", status = "primary", solidHeader = TRUE,
                    collapsible = TRUE,
                    htmlOutput("data_about")
                  )
                ),
                
                HTML("<p></p>"),
              
                fluidRow(
                  HTML("<footer class='footer text-faded text-center py-5'> <div class='container'><p class='m-0 small'>Copyright © Marked Point Process <br>Made by Hamza ABDOULHOUSSEN</p></div> </footer>")
                )
                
        ),
        
        ## PLOT PAGE
        tabItem(tabName = "plot",
                h2("Plot page"),
                fluidRow(
                  box(
                    width = 12,
                    title = "Point Pattern", background = "black",
                    plotOutput("plot_point_pattern"),
                  ),
                  box(
                    width = 12,
                    title = "Point Pattern with ggplot", background = "black",
                    plotOutput("plot_point_pattern_ggplot")
                  )
                )
        ),
        
        ## HISTOGRAM
        tabItem(tabName = "histogram",
                h2("Histogram"),
                fluidRow(
                  box(
                    width = 12,
                    title = "Mark Histogram", background = "black",
                    plotOutput("plot_histo"),
                  )
                )
        ),
        
        
        ## DENSITY
        tabItem(tabName = "density_tab",
                h2("Density"),
                fluidRow(
                  box(
                    width = 12,
                    title = "Density", background = "black",
                    plotOutput("plot_density"),
                  )
                )
        ),
        
        
        ## PLOT FGJK
        tabItem(tabName = "plotFGJK",
                h2("Plot F, G, J and K functions"),
                fluidRow(
                  box(
                    width = 6,
                    title = "F function", background = "black",
                    plotOutput("plot_FGJK_F"),
                  ),
                  box(
                    width = 6,
                    title = "G function", background = "black",
                    plotOutput("plot_FGJK_G"),
                  )
                ),
                
                fluidRow(
                  box(
                    width = 6,
                    title = "J function", background = "black",
                    plotOutput("plot_FGJK_J"),
                  ),
                  box(
                    width = 6,
                    title = "K function", background = "black",
                    plotOutput("plot_FGJK_K"),
                  ),
                )
                
        ),
        
        
        ## ORIENTATION ANALYSIS
        tabItem(tabName = "plotOrientation",
                h2("Orientation Analysis"),
                fluidRow(
                  box(
                    width = 12,
                    title = "Orientation Analysis", background = "black",
                    plotOutput("plot_orientation"),
                  )
                )
        ),
        
        ## MARK FILTER
        tabItem(tabName = "markFilter",
                h2("Orientation Analysis"),
                fluidRow(
                  box(
                    width = 12,
                    title = "Plot by Mark",
                    selectInput("mark_selected", label = h3("Select box"), 
                                choices = list("Choice 1" = 1, "Choice 2" = 2, "Choice 3" = 3), 
                                selected = 1),
                  ),
                  box(
                    width = 12,
                    title = "Orientation Analysis", background = "black",
                    plotOutput("plot_filter")
                  )
                )
        ),
        
        ## K - MEANS
        tabItem(tabName = "k_means",
                h2("K - means"),
                fluidRow(
                  box(
                    width = 12,
                    background = "black",
                    column(6,
                             sliderInput("centers", label = h3("number of clusters"), min = 1, max = 20, value = 5)
                    ),
                    column(6,
                             sliderInput("iterations", label = h3("number of iterations"), min = 1, max = 100, value = 10)
                    ),
                    
                    column(12,
                             selectInput("algorithm", label = h3("Algorithm"),
                                         choices = list("Hartigan-Wong"="Hartigan-Wong", "Lloyd"="Lloyd", 
                                                        "Forgy"="Forgy","MacQueen"="MacQueen"), 
                                         selected = "Lloyd")
                    )
                  ),
                  
                  box(
                    width = 12,
                    title = "Original Plot", background = "black",
                    plotOutput("plot_orig_scatter_plot")
                  ),
                  box(
                    width = 12,
                    title = "K-means cluster Plot", background = "black",
                    plotOutput("plot_k_means")
                  )
                )
        )
    
    )        
    
  )
))

  