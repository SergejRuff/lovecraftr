#' @title Retrieve Lovecraftian Tales by Name or Acronym
#'
#' @description Search for and retrieve text from a collection of Lovecraft stories.
#'
#' @param book A character string representing the full name or acronym of the Lovecraft story to search for.
#'   The search is case-insensitive. If \code{NULL}, the function returns a list of all available stories and their acronyms.
#'
#' @return If a valid book is selected, a data frame with the following columns:
#'   \describe{
#'   \item{text}{The text of the selected story.}
#'     \item{title}{The title of the selected Lovecraft story.}
#'     \item{acronym}{The acronym corresponding to the story.}
#'   }
#'   If no book is specified, the function returns a data frame with two columns:
#'   \describe{
#'     \item{story}{The name of the available story.}
#'     \item{acronym}{The corresponding acronym for each story.}
#'   }
#'
#' @examples
#' # List all available stories
#' unearth_lovecraftian_tales()
#'
#' # Retrieve a story by full name (case-insensitive)
#' unearth_lovecraftian_tales("The shadow over innsmouth")
#'
#' # Retrieve a story by acronym (case-insensitive)
#' unearth_lovecraftian_tales("soi")
#'
#' # Retrieve a story with partial name or acronym (case-insensitive)
#' unearth_lovecraftian_tales("call")
#'
#' # Retrieve a story by acronym
#' unearth_lovecraftian_tales("RH")
#'
#' @export
unearth_lovecraftian_tales <- function(book = NULL) {
  # List of Lovecraft stories with acronyms
  stories <- list(
    "At the mountains of madness" = list(title = "At the mountains of madness", acronym = "MM", text = lovecraftr::mountain_madness),
    "The colour out of space" = list(title = "The colour out of space", acronym = "CS", text = lovecraftr::colour_space),
    "The shadow over Innsmouth" = list(title = "The shadow over Innsmouth", acronym = "SOI", text = lovecraftr::shadow_innsmouth),
    "The Shunned House" = list(title = "The Shunned House", acronym = "TSH", text = lovecraftr::shunned_house),
    "The case of Charles Dexter Ward" = list(title = "The case of Charles Dexter Ward", acronym = "CDW", text = lovecraftr::charles_dexter),
    "The horror at Red Hook" = list(title = "The horror at Red Hook", acronym = "RH", text = lovecraftr::red_hook),
    "The call of Cthulhu" = list(title = "The call of Cthulhu", acronym = "CC", text = lovecraftr::call_of_cthulhu),
    "The Dunwich Horror" = list(title = "The Dunwich Horror", acronym = "DW", text = lovecraftr::dunwich_horror),
    "Writings in the United Amateur" = list(title = "Writings in the United Amateur", acronym = "WUA", text = lovecraftr::united_amateur),
    "The haunter of the dark" = list(title = "The haunter of the dark", acronym = "haunter", text = lovecraftr::haunter_dark),
    "The thing on the door-step" = list(title = "The thing on the door-step", acronym = "door", text = lovecraftr::door_step),
    "The festival" = list(title = "The festival", acronym = "FE", text = lovecraftr::festival),
    "The lurking fear" = list(title = "The lurking fear", acronym = "LURK", text = lovecraftr::lurking),
    "The silver key" = list(title = "The silver key", acronym = "key", text = lovecraftr::key),
    "The quest of Iranon" = list(title = "The quest of Iranon", acronym = "IRA", text = lovecraftr::iranon),
    "He" = list(title = "He", acronym = "HE", text = lovecraftr::he),
    "Cool air" = list(title = "Cool air", acronym = "air", text = lovecraftr::air)
  )

  # If no book is selected, return the list of available stories
  if (is.null(book)) {
    return(data.frame(
      story = names(stories),
      acronym = sapply(stories, function(x) x$acronym),
      stringsAsFactors = FALSE
    ))
  }

  # Case-insensitive search for the book name or acronym
  book_name <- names(stories)[grepl(book, names(stories), ignore.case = TRUE)]
  acronym_match <- sapply(stories, function(x) grepl(book, x$acronym, ignore.case = TRUE))
  book_name <- c(book_name, names(stories)[acronym_match])

  # Remove duplicates if the user matched both the full name and acronym
  book_name <- unique(book_name)

  if (length(book_name) == 0) {
    stop("No matching book found. Please check the name or acronym.")
  }

  # Return the text of the selected book
  selected_story <- stories[[book_name]]
  return(data.frame(
    text = selected_story$text,
    title = selected_story$title,
    acronym = selected_story$acronym
  ))
}
