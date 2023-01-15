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
      menuItem("Plot", tabName="plot", icon=icon("bar-chart-o"))
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
                  selectInput("select", h3("Data Selection"),
                              choices = list(
                                "anemones" = "anemones",
                                "bis" = "bis"), 
                              selected = "anemones")
                  ),
                ),
                
                HTML("<p></p>"),
              
                fluidRow(
                  HTML("<footer class='footer text-faded text-center py-5'> <div class='container'><p class='m-0 small'>Copyright © Marked Point Process <br>Made by Hamza ABDOULHOUSSEN</p></div> </footer>")
                )
                
        ),
        
        ## PLOT PAGE
        tabItem(tabName = "plot",
                h2("Plot page"),
                
        )
        
        
    
    )        
    
  )
))

  