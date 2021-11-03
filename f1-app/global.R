library(tidyverse)
library(shiny)
library(bs4Dash)
library(shinybusy)
library(lubridate)
library(reactable)
library(plotly)
#library(tidytuesdayR)

## Load Data
#load("dat.Rda")
load("../drivers.Rda")
load("../results.Rda")
load("../lap_times.Rda")
load("../constructor_standings.Rda")
# load("pit_stops.Rda")


## Source files
source("./modules/drivers.R")
source("./modules/constructors.R")
source("./modules/lap_analysis.R")

# ## Table of drivers with their ranking by week and end of season
# # dat$drivers -> gives demographic data on the drivers
#
# races <- dat$races %>%
#   select(raceId, year)
#
# simple_res <- dat$results %>%
#   select(driverId, constructorId, raceId, points, statusId)
#
# summary_res <- dat$results %>%
#   select(driverId, constructorId, raceId, points, statusId)
#
# races_simple_res <- merge(simple_res, races, by = "raceId")
# races_simple_res <- races_simple_res %>%
#   select(driverId:year) %>%
#   unique()
#
# drivers <- dat$drivers
# colnames(drivers)[colnames(drivers)=="nationality"] <-  "driver_nationality"
# colnames(drivers)[colnames(drivers)=="url"] <-  "driver_url"
#
# constructors <- dat$constructors
# colnames(constructors)[colnames(constructors)=="nationality"] <-  "constructor_nationality"
# colnames(constructors)[colnames(constructors)=="url"] <-  "constructor_url"
#
# racer_standings <- merge(races_simple_res, drivers, by = "driverId")
# racer_standings <- merge(racer_standings, constructors, by = "constructorId")
#
# drivers <- merge(drivers, racer_standings %>% select(driverId, year, constructorRef), by = "driverId")
# drivers <- merge(drivers, constructors, by = "constructorRef")
#
#
#
#
# save(drivers, file = "drivers.Rda")
#
# ## Constructor Points by race over the years
# constructor_standings <- dat$constructor_standings
# constructor_standings <- merge(constructor_standings, dat$races, by = "raceId")
# constructor_standings <- constructor_standings %>%
#   rename(race_name = name)
# constructor_standings <- merge(constructor_standings, constructors, by = "constructorId")
# constructor_standings <- constructor_standings %>%
#   rename(constructor_name = name)
#
# save(constructor_standings, file = "constructor_standings.Rda")
#
# ## Lap times By Racer, Season, Race
# # Compare the laptimes - the user can select season and race - then plot laptimes for each driver
# lap_times <- dat$lap_times
# lap_times <- lap_times %>%
#   rename(lap_time = time)
# lap_times <- merge(lap_times, dat$races, by = "raceId")
# lap_times <- lap_times %>%
#   rename(race_time = time,
#          race_name = name)
# lap_times <- merge(lap_times, drivers, by = c("driverId", "year"), all.x = TRUE)
#
# save(lap_times, file = "lap_times.Rda")
#
# ## Pit Stops by Team
# # Which lab did each team pit for each race?
# # How long was the pit times for each team by race
# pit_stops <- dat$pit_stops
# pit_stops <- pit_stops %>%
#   rename(pit_stop_time = time)
# pit_stops <- merge(pit_stops, dat$races, by = "raceId")
# pit_stops <- pit_stops %>%
#   rename(race_name = name, race_time = time)
# pit_stops <- merge(pit_stops, drivers %>% select(-year), by = "driverId")
# pit_stops <- pit_stops %>%
#   rename(constructor_name = name)
#
# save(pit_stops, file = "pit_stops.Rda")
#
#
# ## Results for each race
# results <- dat$results
# results <- merge(results, dat$status, by = "statusId")
# results <- results %>%
#   rename(results_time = time)
# results <- merge(results, dat$races, by = "raceId")
# results <- results %>%
#   rename(race_time = time)
#
# save(results, file = "results.Rda")
