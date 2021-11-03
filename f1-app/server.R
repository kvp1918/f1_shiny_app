shinyServer(function(input, output) {
    driversServer("drivers")
    constructorsServer("constructors")
    lapsServer("laps")
})
