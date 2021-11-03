lapsUI <- function(id) {
  ns <- NS(id)
  column(width = 12,
         fluidRow(
           bs4Card(
             title = "Select Season and Race",
             width = 3,
             column(
               width = 12,
               selectInput(
                 width = '50%',
                 ns("year"),
                 "Year:",
                 choices = sort(unique(lap_times$year)),
                 selected = max(unique(lap_times$year))
               ),
               br(),
               uiOutput(ns("raceSelection"))
             )
           ),
           bs4Card(
             title = "Race Information",
             width = 9,
             column(width = 12,
                    h3(textOutput(ns("raceName"))),
                    p(textOutput(ns("raceDate"))),
                    p(textOutput(ns("raceLink")))
             )
           )

         ),
         bs4Card(
           width = 12,
           title = "Lap Times",
           plotlyOutput(ns("plot"))
         )
         )


}

lapsServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- NS(id)
    output$raceSelection <- renderUI({
      selectInput(ns("race"), "Race:", choices =
                    unique((lap_times[lap_times$year==input$year, "race_name"])))
    })

    observeEvent(input$race, {
      output$raceName <- renderText({
        input$race
      })

      output$raceDate <- renderPrint({
        lap_times %>%
          filter(year == input$year & race_name == input$race) %>%
          slice(1) %>%
          select(date) %>% array()
      })

      output$raceLink <- renderPrint({
        lap_times %>%
          filter(year == input$year & race_name == input$race) %>%
          slice(1) %>%
          select(url) %>% array()
      })

      output$plot <- renderPlotly({
        p <- lap_times %>%
          filter(year == input$year & race_name == input$race) %>%
          mutate(driver_name = paste(forename,surname )) %>%
          rename(team = name) %>%
          ggplot(aes(x = reorder(driver_name, position), y = milliseconds, color = team, group = team)) + geom_boxplot() +
          xlab("Driver") + ylab("Lap Times (ms)") +
          theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

        ggplotly(p, tooltip = c("driver_name", "team"))
      })
    })







  })
}