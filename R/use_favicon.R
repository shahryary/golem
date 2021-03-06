#' Add a favicon to your shinyapp
#'
#' @param path Path to your favicon file (.ico or .png) 
#' @param pkg Path to the root of the package. Default is `"."`
#' @rdname favicon
#' @export
#' 
#' @importFrom attempt stop_if_not
#'
#' @examples
#' \donttest{
#' if (interactive()){
#'   use_favicon()
#'   use_favicon(path='path/to/your/favicon.ico')
#' }
#' }
use_favicon <- function(path, pkg = "."){
  
  if (missing(path)){
    path <- golem_sys("shinyexample/inst/app/www", "favicon.ico")
  } 
  
  ext <- tools::file_ext(path)
  stop_if_not(ext, ~ .x %in% c("png",'ico'), 
              "favicon must have .ico or .png extension")
  
  path <- normalizePath(path)
  
  old <- setwd(normalizePath(pkg))
  on.exit(setwd(old))
  
  to <- file.path(normalizePath(pkg), "inst/app/www", glue::glue("favicon.{ext}"))
  
  if (! (path == to)) {
    file.copy(
      overwrite = TRUE,
      path, 
      to
    )
    cat_green_tick(glue::glue("favicon.{ext} created at {to}"))
  }
  
  cat_rule("Change / Add in the app_ui function")
  cat_line(darkgrey(glue('golem::favicon("www/favicon.{ext}")')))
  cat_line()
  
}

#' @rdname favicon
#' @export
remove_favicon <- function(
  path = "inst/app/www/favicon.ico"
){
  if (file.exists(path)){
    cat_green_tick(
      sprintf(
        "Removing favicon at %s", 
        path
      )
    )
    unlink(path)
  } else {
    cat_red_bullet(
      sprintf(
        "No file found at %s", 
        path
      )
    )
  }
}

#' Add favicon to your app
#'
#' This function adds the favicon from `ico` to your shiny app.
#' 
#' @param ico path to favicon file
#' @param rel rel
#'
#' @export
#' @importFrom htmltools tags
favicon <- function( ico = "www/favicon.ico", rel="shortcut icon" ){
  tags$head(tags$link(rel= rel, href= ico))
}
