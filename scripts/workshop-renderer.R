create_workshop_renderer <- function(format) {
  if (identical(format, "latex")) {
    return(list(
      name = "latex",
      render_chunk = render_latex_workshop_chunk
    ))
  }

  stop("Unsupported renderer format: ", format)
}

render_workshop_chunk <- function(renderer, all_segments, config, target_exercise, target_chunk_index) {
  if (is.null(renderer$render_chunk) || !is.function(renderer$render_chunk)) {
    stop("Renderer must expose a render_chunk function")
  }

  renderer$render_chunk(
    all_segments = all_segments,
    config = config,
    target_exercise = target_exercise,
    target_chunk_index = target_chunk_index
  )
}
