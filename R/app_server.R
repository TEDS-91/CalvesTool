#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic

  set.seed(122)
  histdata <- rnorm(500)

  histo <- reactive({

    data.frame(calf_id = seq(1, 100, 1),
               avg30d = rnorm(100, 0.5, 0.1),
               avdg60d = rnorm(100, 0.7, 0.1),
               avdg90g = rnorm(100, 0.8, 0.1))

  })

  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })

  output$tabela <- renderTable({

    histo() |>
      dplyr::slice(1:input$slider)

  })

  output$histograma <- renderPlot({

    histo() |>
      dplyr::slice(1:input$slider) |>
      ggplot2::ggplot( ggplot2::aes(x = avg30d)) +
      ggplot2::geom_histogram()

  })


}
