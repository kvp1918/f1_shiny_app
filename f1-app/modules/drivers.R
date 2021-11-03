driversUI <- function(id) {
  ns <- NS(id)
  column(width = 12,
    fluidRow(
    bs4Card(
            title = "Select Season",
            width = 3,
            selectInput(ns("year"),
                        "Year:",
                        choices = sort(unique(drivers$year)),
                        selected = max(unique(drivers$year))
                        )
            ),
    bs4Card(
            title = "Drivers",
            width = 8,
            reactableOutput(ns("driverTable")))
  ),
  bs4Card(
    title = "Season Summary",
    width = 12,
    fluidRow(
      bs4InfoBoxOutput(
        ns("seasonPoints"),
        width = '20%'
        ),
      column(
        width = 2
        ),
      reactableOutput(
        ns("seasonStatusesTable"),
        width = "50%"
        )
    )
  ),
  bs4Card(
    title = "Race Outcomes",
    width = 12,
    reactableOutput(ns("individualDriverRaceTable"))
    )
  )
}

driversServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    output$driverTable <- renderReactable({
      reactable(drivers %>%
                  filter(year == input$year) %>%
                  mutate(driver_name = paste(forename, surname)) %>%
                  select(driverId, driver_name, driver_nationality, dob, name, constructor_nationality),
                columns = list(
                  driverId = colDef(show = FALSE),
                  driver_name = colDef(name = "Name"),
                  driver_nationality = colDef(name = "Driver Nationality"),
                  dob = colDef(name = "Date of Birth"),
                  name = colDef(name = "Team"),
                  constructor_nationality = colDef(name = "Team Country")
                ),
                highlight = TRUE,
                searchable = TRUE,
                defaultPageSize = 30,
                onClick = "select",
                selection = "single")
    })


    observe({
      selectedDriver <- getReactableState("driverTable", "selected")
      if(!is.null(selectedDriver)) {
        selected_driver <- drivers %>%
          filter(year == input$year) %>%
          slice(selectedDriver) %>%
          select(driverId)


        output$seasonPoints <- renderbs4InfoBox({
          bs4InfoBox(
            title = "Total Points",
            icon = icon("star"),
            color = "warning",
            value = results %>%
              filter(driverId == selected_driver$driverId) %>%
              filter(year == input$year) %>%
              summarise(total_pts = sum(points))
          )

        })

        output$seasonStatusesTable <- renderReactable({
          reactable(
            results %>%
              filter(driverId == selected_driver$driverId) %>%
              filter(year == input$year) %>%
              count(status),
            columns = list(
              status = colDef(name = "Status"),
              n = colDef(name = "Count")
            )
          )
        })

        output$individualDriverRaceTable <- renderReactable({
          reactable(
            results %>%
              filter(driverId == selected_driver$driverId) %>%
              filter(year == input$year) %>%
              select(name, date, status, points, rank, fastestLapTime, fastestLapSpeed, laps),
            columns = list(
              name = colDef(name = "Race"),
              date = colDef(name = "Date"),
              status = colDef(name = "Result"),
              points = colDef(name = "Points"),
              rank = colDef(name = "Rank"),
              fastestLapTime = colDef(name = "Fastest Lap Time"),
              fastestLapSpeed = colDef(name = "Fastest Lap Speed"),
              laps = colDef(name = "Laps")
            )
            )
        })
      }


    })


  })
}