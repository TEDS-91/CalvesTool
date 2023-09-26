#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),

    # Your application UI logic
    # fluidPage(
    #   h1("CalvesTool")
    # )

    bs4Dash::dashboardPage(
      bs4Dash::dashboardHeader(title = "Calf Performance Monitor"),
      bs4Dash::dashboardSidebar(
        bs4Dash::bs4SidebarMenu(

          bs4Dash::bs4SidebarMenuItem(
            "Overall",
            tabName = "herd_calibration",
            icon    = tags$i(fontawesome::fa("cow"))),
          bs4Dash::bs4SidebarMenuItem(
            "Overall2",
            tabName = "herd_calibration2",
            icon    = tags$i(fontawesome::fa("cow")))
      )),
      bs4Dash::dashboardBody(
        # Boxes need to be put in a row (or column)

        bs4Dash::bs4TabItems(

          bs4Dash::bs4TabItem(
            tabName = "herd_calibration",
            fluidRow(
              bs4Dash::box(plotOutput("plot1", height = 250)),

              bs4Dash::box(
                title = "Controls",
                sliderInput("slider", "Number of observations:", 1, 100, 50)
              ),
              bs4Dash::box(
                title = "Performance",
                tableOutput("tabela")
              ),
              bs4Dash::box(
                title = "Performance",
                plotOutput("histograma")
              )

              ),

              ),

          bs4Dash::bs4TabItem(
            tabName = "herd_calibration2",
            #mod_nh3_emissions_ui("nh3_emissions"),
            )
      )
    )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "CalvesTool"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
