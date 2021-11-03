constructorsUI <- function(id) {
  ns <- NS(id)
  column(width = 12,
         bs4Card(
           title = "Constructor Results",
           width = 12,
           fluidRow(
             selectInput(
               width = '10%',
               ns("year"),
               "Year:",
               choices = sort(unique(constructor_standings$year)),
               selected = max(unique(constructor_standings$year))
             ),
             column(
               width = 3
             ),
             reactableOutput(
               width = '50%',
               ns("constructorTable")
               )
             )
         ),
         bs4Card(
           width = 12,
           title = "Winningest Teams",
           plotlyOutput(ns("plot"))
         )
  )
}

constructorsServer <- function(id) {
  moduleServer(id, function(input, output, session) {

    output$constructorTable <- renderReactable({
      reactable(constructor_standings %>%
                  filter(year == input$year) %>%
                  group_by(constructor_name) %>%
                  summarise(total_pts = sum(points),
                            total_wins = sum(wins)) ,
                columns = list(
                  constructor_name = colDef(name = "Name"),
                  total_pts = colDef(name = "Points"),
                  total_wins = colDef(name = "Wins")
                ),
                highlight = TRUE,
                searchable = TRUE,
                defaultPageSize = 30)
    })

    output$plot <- renderPlotly({
      p <- constructor_standings %>%
        group_by(year, constructor_name) %>%
        summarise(total_pts = sum(points)) %>%
        ungroup() %>%
        group_by(year) %>%
        mutate(winner = if_else(total_pts == max(total_pts), 1, 0)) %>%
        ungroup() %>%
        group_by(constructor_name) %>%
        mutate(n_wins = sum(winner)) %>%
        ungroup() %>%
        filter(n_wins > 0) %>%
        ggplot( aes(x=reorder(constructor_name, n_wins), y=n_wins)) +
        geom_segment(aes(xend=constructor_name, yend=0)) +
        geom_point(size=4, color="orange") +
        coord_flip() +
        theme_bw() +
        xlab("") +
        ylab("Number of Wins")
      ggplotly(p, tooltip = "n_wins")
    })


  })
}