# Marked Point Process

------------------------------------------------

- [Marked Point Process](#marked-point-process)
  - [Presentation](#presentation)
  - [Project](#project)
  - [Author](#author)
  - [Requirements](#requirements)
  - [Data](#data)
  - [Boards](#boards)
    - [Home](#home)
    - [Plot](#plot)
    - [Histogram](#histogram)
    - [F G J and K Functions](#f-g-j-and-k-functions)
    - [Orientation analysis](#orientation-analysis)
    - [Mark Filter](#mark-filter)
    - [K-Means](#k-means)
  - [Links](#links)

## Presentation

Marked Point Process is a DashBoard in `R`.  
You can load specific data and estimate the main charactical functions and properties.  

## Project
Spatial Statistic project at TELECOM Nancy x Faculté des sciences et technologies x Ecole des Mines de Nancy

Professor :
- Radu Stoica

## Author
- ABDOULHOUSSEN Hamza

## Requirements
```R
library(shiny)
library(shinydashboard)
library(shinyjs)
library(markdown)
library(ggplot2)
library(spatstat)
```

## Data
- amacrine
- anemones
- ants
- betacells
- bramclecanes

data are imported from [spatstat r package data](https://cran.r-project.org/web/packages/spatstat.data/spatstat.data.pdf)

## Boards

### Home
You choose the data set and see the description

### Plot
Plot the point pattern and the marks

### Histogram
See the number of points for each mark

### F G J and K Functions
See spatial statistice estimation of F G J and K Functions

### Orientation analysis
Create orientation mark with the points and plot each orientation

### Mark Filter
- Choose a mark

See the plot for the points with the chosen mark

### K-Means
- Choose the number of clusters
- Choose the number of iterations
- Choose the method

You can see the original plot and a plot with the clusters made by K-means


## Links
- [Shiny Tutorial](https://shiny.rstudio.com/tutorial/written-tutorial/lesson1/)