dashboardPage(
    # preloader = list(html = spin_1(), color = "#333e48"),
    header = dashboardHeader(title = dashboardBrand(title = "F1 Dashboard",
                                                    color = "danger",
                                                    opacity = 0.8)),
    sidebar = dashboardSidebar(title = "F1 Dashboard",
                               status = "danger",
                               skin = "light",
                               # src = "Brain_only.png",
                               sidebarMenu(id = "sidebarMenu",
                                           flat = TRUE,
                                           menuItem(text = "Drivers", tabName = "driversTab",
                                                    icon = icon("users")),
                                           menuItem(
                                               "Constructors",
                                               tabName = "constructorsTab",
                                               icon = icon("sitemap")
                                           ),
                                           menuItem(
                                               "Lap Analysis",
                                               tabName = "lapsTab",
                                               icon = icon("road")
                                           )
                               )),
    body = dashboardBody(
        tabItems(tabItem(tabName = "driversTab", driversUI("drivers")),
                 tabItem(tabName = "constructorsTab", constructorsUI("constructors")),
                 tabItem(tabName = "lapsTab", lapsUI("laps"))
                 )
    )
)
