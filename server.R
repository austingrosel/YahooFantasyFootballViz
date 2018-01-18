#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  filtered_data = reactive({
    if(input$team == "All") {
      draft_points[!is.na(draft_points$Pos),]
    } else {
      draft_points %>%
        filter(Team == input$team) %>% select(-Round.Pick) %>% arrange(Ovr.Pick) %>%
        ungroup()
    }
  })
  
  output$draft_table = DT::renderDataTable({
    if(input$team != "All") {
      filtered_data()
    }
  }, options = list(dom = 't', pageLength = 20))
  
  output$draft_plot = renderPlotly({
    if(input$metric_team == "Fan.Pts") {
      ggplotly(ggplot(aes(x = Ovr.Pick, y = Fan.Pts, color = Team), data = filtered_data()) +
                 geom_point(aes(x = Ovr.Pick, y = Fan.Pts), data = draft_points, colour = alpha("grey", 0.7)) +
                 geom_point() + geom_smooth(span = 2, se = F)+ ggtitle("Fantasy Points by Draft Position") + theme_fivethirtyeight())
    } else if (input$metric_team == "Fan.Pts.Per.Game") {
      ggplotly(ggplot(aes(x = Ovr.Pick, y = Fan.Pts.Per.Game, color = Team), data = filtered_data()) +
                 geom_point(aes(x = Ovr.Pick, y = Fan.Pts.Per.Game), data = draft_points, colour = alpha("grey", 0.7)) +
                 geom_point() + geom_smooth(span = 2, se = F) + ggtitle("Fantasy Points by Draft Position") + theme_fivethirtyeight())
    } else if (input$metric_team == "Std.Fan.Pts") {
      ggplotly(ggplot(aes(x = Ovr.Pick, y = Std.Fan.Pts, color = Team), data = filtered_data()) +
                 geom_point(aes(x = Ovr.Pick, y = Std.Fan.Pts), data = draft_points, colour = alpha("grey", 0.7)) +
                 geom_point() + geom_smooth(span = 2, se = F)+ ggtitle("Fantasy Points by Draft Position") + theme_fivethirtyeight())
    } else if (input$metric_team == "Std.Fan.Pts.Per.Game") {
      ggplotly(ggplot(aes(x = Ovr.Pick, y = Std.Fan.Pts.Per.Game, color = Team), data = filtered_data()) +
                 geom_point(aes(x = Ovr.Pick, y = Std.Fan.Pts.Per.Game), data = draft_points, colour = alpha("grey", 0.7)) +
                 geom_point() + geom_smooth(span = 2, se = F)+ ggtitle("Fantasy Points by Draft Position") + theme_fivethirtyeight())
    }

  })
  
  filtered_data_pos = reactive({
    if(input$position == "All") {
      draft_points[!is.na(draft_points$Pos),]
    } else {
      draft_points %>%
        filter(Pos == input$position) %>% select(-Round.Pick) %>% arrange(Ovr.Pick) %>%
        ungroup()
    }
  })
  
  output$draft_table_pos = DT::renderDataTable(
    if(input$position != "All") {
      filtered_data_pos()
    }, filter = "top", options = list(pageLength = 25))
  
  output$draft_plot_pos = renderPlotly({
    if(input$metric_pos == "Fan.Pts") {
      ggplotly(ggplot(aes(x = Ovr.Pick, y = Fan.Pts, color = Pos), data = filtered_data_pos()) +
                 geom_point(aes(x = Ovr.Pick, y = Fan.Pts), data = draft_points, colour = alpha("grey", 0.7)) +
                 geom_point() + geom_smooth(span = 2, se = F)+ ggtitle("Fantasy Points by Draft Position") + theme_fivethirtyeight())
    } else if (input$metric_pos == "Fan.Pts.Per.Game") {
      ggplotly(ggplot(aes(x = Ovr.Pick, y = Fan.Pts.Per.Game, color = Pos), data = filtered_data_pos()) +
                 geom_point(aes(x = Ovr.Pick, y = Fan.Pts.Per.Game), data = draft_points, colour = alpha("grey", 0.7)) +
                 geom_point() + geom_smooth(span = 2, se = F)+ ggtitle("Fantasy Points by Draft Position") + theme_fivethirtyeight())
    } else if (input$metric_pos == "Std.Fan.Pts") {
      ggplotly(ggplot(aes(x = Ovr.Pick, y = Std.Fan.Pts, color = Pos), data = filtered_data_pos()) +
                 geom_point(aes(x = Ovr.Pick, y = Std.Fan.Pts), data = draft_points, colour = alpha("grey", 0.7)) +
                 geom_point() + geom_smooth(span = 2, se = F)+ ggtitle("Fantasy Points by Draft Position") + theme_fivethirtyeight())
    } else if (input$metric_pos == "Std.Fan.Pts.Per.Game") {
      ggplotly(ggplot(aes(x = Ovr.Pick, y = Std.Fan.Pts.Per.Game, color = Pos), data = filtered_data_pos()) +
                 geom_point(aes(x = Ovr.Pick, y = Std.Fan.Pts.Per.Game), data = draft_points, colour = alpha("grey", 0.7)) +
                 geom_point() + geom_smooth(span = 2, se = F)+ ggtitle("Fantasy Points by Draft Position") + theme_fivethirtyeight())
    }
  })
  
  df = reactive({
    player_points %>% arrange(-Fan.Pts)
  })
  
  output$raw_data = DT::renderDataTable(
    df(), filter = "top", options = list(pageLength = 25))
  
})
