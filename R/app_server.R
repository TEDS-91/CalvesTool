#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic

  histo <- reactive({

    expand.grid(calf_id = seq(1, 30, 1),
                age_d = c(1, 30, 60)) %>%
      dplyr::bind_cols(weight = c(rnorm(30, 35, 2),
                                  rnorm(30, 50, 3),
                                  rnorm(30, 70, 4)))

  })

  output$tabela <- renderTable({

    histo() %>%
      dplyr::filter(calf_id %in% c(seq(1, input$slider)))

  })

  output$histograma <- plotly::renderPlotly({

    plotly::ggplotly(
    histo() %>%
      dplyr::filter(calf_id %in% c(seq(1, input$slider))) %>%
      dplyr::mutate(calf_id = as.factor(calf_id)) %>%
      ggplot2::ggplot( ggplot2::aes(x = age_d, y = weight, col = calf_id)) +
      ggplot2::theme_bw() +
      ggplot2::geom_point() +
      ggplot2::geom_line(ggplot2::aes(x = age_d, y = weight, col = calf_id))
)
  })


}
