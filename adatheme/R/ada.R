#' ADA theme for ggplot
#'
#' Create figures using the ADA plotting theme.
#' @export
theme_ada <- function(){
  ada_theme <- ggplot2::theme_bw() + ggplot2::theme(
    panel.background = ggplot2::element_rect(fill = "white", color = "white"),
    panel.border = ggplot2::element_blank(),
    legend.key = ggplot2::element_rect(fill = "white", color = "white"),
    panel.grid.major.y = ggplot2::element_line(colour$ada$get("gray")),
    panel.grid.major.x = ggplot2::element_blank(),
    strip.background = ggplot2::element_rect(colour = NA,
                                             fill = colour$ada$get("lightblue100")),
    axis.text = ggplot2::element_text(colour = "black"),
    axis.ticks = ggplot2::element_line(colour = colour$ada$get("gray")),
    axis.title = ggplot2::element_text(colour = "black"),
    plot.title = ggplot2::element_text(hjust = 0,
                                       margin = ggplot2::margin(b = 20))
  )
  ada_theme
}


#' Remove scales for ggplot
#'
#' Removes x and / or y scales from the plot
#' @param X, horizontal axis i.e. x
#' @param Y, vertical axis i.e. y
#' @export
#' @examples
#' anonymous(X = x, Y = y)
anonymous <- function(X, Y) {
  args <- as.list(match.call())

  if (nargs() == 1){
    if ("X" %in% names(args)) {
      anonymousX <- ggplot2::theme(
        axis.text.x = ggplot2::element_blank(),
        axis.ticks.x = ggplot2::element_blank(),
        axis.title.x = ggplot2::element_blank())
      return(anonymousX)
    } else {
      anonymousY <- ggplot2::theme(
        axis.text.y = ggplot2::element_blank(),
        axis.ticks.y = ggplot2::element_blank(),
        axis.title.y = ggplot2::element_blank())
      return(anonymousY)
    }
  }

  if (nargs() == 2) {
    anonymousXY <- ggplot2::theme(
      axis.text = ggplot2::element_blank(),
      axis.ticks = ggplot2::element_blank(),
      axis.title = ggplot2::element_blank())
    return(anonymousXY)
  }

}

#' ADA color palettes
#'
#' ADA color palettes.
#'
#' @param scheme \code{character}. One of \code{"primary"},
#' \code{"secondary"}, \code{"tertiary"}, or \code{"graph"}.
#'
#' @export
#' @examples
#' library("scales")
#' ada_palette("primary")
ada_palette <- function(scheme="graph") {
  colorlists <-
    list(primary = c(colour$ada$get("blue"), colour$ada$get("mediumblue"),
                     colour$ada$get("lightblue")),
    secondary = c(colour$ada$get("violet"), colour$ada$get("purple"),
                  colour$ada$get("lightpurple"), colour$ada$get("green")),
    tertiary =  c(colour$ada$get("darkgreen"), colour$ada$get("lightgreen"),
                  colour$ada$get("yellow"), colour$ada$get("orange"),
                  colour$ada$get("red"), colour$ada$get("pink")),
    graph = c("#3c4b99", "#c93f55",
              "#eacc62", "#469d76",
              "#924099",
              "#df9ed4", colour$ada$get("lightgreen"),
              colour$ada$get("pink"), colour$ada$get("darkbrown"),
              colour$ada$get("lightbrown"), colour$ada$get("olive")),
    tonal_mediumblue = c(colour$ada$get("mediumblue"), colour$ada$get("mediumblue300"),
                         colour$ada$get("mediumblue100"),  colour$ada$get("mediumblue50")),
    tonal_lightpurple = c(colour$ada$get("lightpurple"), colour$ada$get("lightpurple300"),
                          colour$ada$get("lightpurple100"), colour$ada$get("lightpurple50")),
    tonal_green = c(colour$ada$get("green"), colour$ada$get("green300"),
                    colour$ada$get("green100"), colour$ada$get("green50")),
    tonal_blue = c(colour$ada$get("blue"), colour$ada$get("blue300"),
                         colour$ada$get("blue100"), colour$ada$get("blue50")),
    tonal_lightblue = c(colour$ada$get("lightblue"), colour$ada$get("lightblue300"),
                   colour$ada$get("lightblue100"), colour$ada$get("lightblue50")),
    tonal_violet = c(colour$ada$get("violet"), colour$ada$get("violet300"),
                    colour$ada$get("violet100"), colour$ada$get("violet50")),
    tonal_purple = c(colour$ada$get("purple"), colour$ada$get("purple300"),
                          colour$ada$get("purple100"), colour$ada$get("purple50")),
    tonal_darkgreen = c(colour$ada$get("darkgreen"), colour$ada$get("darkgreen300"),
                    colour$ada$get("darkgreen100"), colour$ada$get("darkgreen50")),
    tonal_lightgreen = c(colour$ada$get("lightgreen"), colour$ada$get("lightgreen300"),
                    colour$ada$get("lightgreen100"), colour$ada$get("lightgreen50")),
    tonal_yellow = c(colour$ada$get("yellow"), colour$ada$get("yellow300"),
                     colour$ada$get("yellow100"), colour$ada$get("yellow50")),
    tonal_orange = c(colour$ada$get("orange"), colour$ada$get("orange300"),
                     colour$ada$get("orange100"), colour$ada$get("orange50")),
    tonal_red = c(colour$ada$get("red"), colour$ada$get("red300"),
                     colour$ada$get("red100"), colour$ada$get("red50")),
    tonal_pink = c(colour$ada$get("pink"), colour$ada$get("pink300"),
                     colour$ada$get("pink100"), colour$ada$get("pink50")),
    tonal_gray = c(colour$ada$get("gray"), colour$ada$get("gray300"),
                   colour$ada$get("gray100"), colour$ada$get("gray50")),
              colour$ada$get("beige"), colour$ada$get("lightpink")
    )
  scales::manual_pal(unname(colorlists[[scheme]]))
}


#' ADA fill colour scales
#'
#' Discrete colour scales from ADA
#'
#' @param palette, pick a colour palette e.g. graph, tertiary, secondary or primary
#' @inheritParams ada_palette
#' @inheritParams ggplot2::scale_colour_hue
#' @rdname scale_ada
#' @export
scale_fill_ada <- function(palette = "graph", ...) {
  ggplot2::discrete_scale("fill", "ADA", ada_palette(palette), ...)
}


#' @inheritParams ada_palette
#' @inheritParams ggplot2::scale_colour_hue
#' @rdname scale_ada
#' @export
scale_colour_ada <- function(palette = "graph", ...) {
  ggplot2::discrete_scale("colour", "ADA", ada_palette(palette), ...)
}

#' @export
#' @rdname scale_ada
scale_color_ada <- scale_colour_ada

#' Overload ggplot2 scales to ADA scales
#'
#' @inheritParams ggplot2::scale_colour_discrete
#' @export
scale_colour_discrete <- function(...) scale_colour_ada(...)

#' Overload ggplot2 scales to ADA scales
#'
#' @inheritParams  ggplot2::scale_fill_discrete
#' @export
scale_fill_discrete <- function(...) scale_fill_ada(...)
