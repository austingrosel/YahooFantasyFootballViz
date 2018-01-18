#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(DT)
library(ggthemes)
library(ggplot2)
library(plotly)
library(dplyr, warn.conflicts = FALSE)
library(readr)

# Define UI for application that draws a histogram
shinyUI(fluidPage(theme = "bootstrap.css",
  
  # Application title
  titlePanel("2017 Fantasy Football Draft Review"),
  
  # Sidebar with a slider input for number of bins
  tabsetPanel(
    tabPanel("Draft-Team",
             HTML("<b>Select the team and metric to compare the fantasy points versus the draft pick.</b>"),
             fluidRow(br()),
             HTML("<em>Filters with 'Std' have been standardized by position</em>"),
             fluidRow(br()),
             fluidRow(
               column(3,
                      selectInput("team",
                                  "Team:",
                                  choices = c("All", unique(draft_points$Team[order(draft_points$Team)])))),
               column(3,
                      selectInput("metric_team",
                                  "Metric:",
                                  selected = "Fan.Pts.Per.Game",
                                  choices = c("Fan.Pts", "Fan.Pts.Per.Game",
                                              "Std.Fan.Pts", "Std.Fan.Pts.Per.Game")))
             ),
             
             fluidRow(br()),
             
             fluidRow(
               column(12, plotlyOutput("draft_plot"))
             ),
             
             fluidRow(
               column(12, DT::dataTableOutput("draft_table"))
             )
    ),
    tabPanel("Draft-Position",
             fluidRow(
               column(3,
                      selectInput("position",
                                  "Position:",
                                  choices = c("All","QB", "RB", "WR", "TE", "K", "DEF"))),
               column(3,
                      selectInput("metric_pos",
                                  "Metric:",
                                  selected = "Fan.Pts.Per.Game",
                                  choices = c("Fan.Pts", "Fan.Pts.Per.Game",
                                              "Std.Fan.Pts", "Std.Fan.Pts.Per.Game")))
             ),
             
             fluidRow(br()),
             
             fluidRow(
               column(12, plotlyOutput("draft_plot_pos", height = 500))
             ),
             
             fluidRow(
               column(12, DT::dataTableOutput("draft_table_pos"))
             )
    ),
    tabPanel("Raw Data",
             HTML("<em>Final.Rank is calculated based on total Fan.Pts</em>"),
             fluidRow(br()),
             fluidRow(
               column(12, DT::dataTableOutput("raw_data"))
             )
    )
  )
  )
)
