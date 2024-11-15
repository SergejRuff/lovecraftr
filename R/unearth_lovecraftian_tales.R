#' @title Retrieve Lovecraftian Tales by Name or abbreviation
#'
#' @description Search for and retrieve text from a collection of Lovecraft stories.
#'
#' @param book A character string representing the full name or abbreviation of the Lovecraft story to search for.
#'   The search is case-insensitive. If \code{NULL}, the function returns a list of all available stories and their abbreviations.
#'
#' @return If a valid book is selected, a data frame with the following columns:
#'   \describe{
#'   \item{text}{The text of the selected story.}
#'     \item{title}{The title of the selected Lovecraft story.}
#'     \item{abbreviation}{The abbreviation corresponding to the story.}
#'   }
#'   If no book is specified, the function returns a data frame with two columns:
#'   \describe{
#'     \item{story}{The name of the available story.}
#'     \item{abbreviation}{The corresponding abbreviation for each story.}
#'   }
#'
#' @examples
#' # List all available stories
#' unearth_lovecraftian_tales()
#'
#' # Retrieve a story by full name (case-insensitive)
#' unearth_lovecraftian_tales("The shadow over innsmouth")
#'
#' # Retrieve a story by abbreviation (case-insensitive)
#' unearth_lovecraftian_tales("soi")
#'
#' # Retrieve a story with partial name or abbreviation (case-insensitive)
#' unearth_lovecraftian_tales("call")
#'
#' # Retrieve a story by abbreviation
#' unearth_lovecraftian_tales("RH")
#'
#' @export
unearth_lovecraftian_tales <- function(book = NULL) {
  # List of Lovecraft stories with abbreviations
  stories <- list(
    "At the mountains of madness" = list(title = "At the mountains of madness", abbreviation = "MM", text = lovecraftr::mountain_madness),
    "The colour out of space" = list(title = "The colour out of space", abbreviation = "CS", text = lovecraftr::colour_space),
    "The shadow over Innsmouth" = list(title = "The shadow over Innsmouth", abbreviation = "SOI", text = lovecraftr::shadow_innsmouth),
    "The Shunned House" = list(title = "The Shunned House", abbreviation = "TSH", text = lovecraftr::shunned_house),
    "The case of Charles Dexter Ward" = list(title = "The case of Charles Dexter Ward", abbreviation = "CDW", text = lovecraftr::charles_dexter),
    "The horror at Red Hook" = list(title = "The horror at Red Hook", abbreviation = "RH", text = lovecraftr::red_hook),
    "The call of Cthulhu" = list(title = "The call of Cthulhu", abbreviation = "CC", text = lovecraftr::call_of_cthulhu),
    "The Dunwich Horror" = list(title = "The Dunwich Horror", abbreviation = "DW", text = lovecraftr::dunwich_horror),
    "Writings in the United Amateur" = list(title = "Writings in the United Amateur", abbreviation = "WUA", text = lovecraftr::united_amateur),
    "The haunter of the dark" = list(title = "The haunter of the dark", abbreviation = "haunter", text = lovecraftr::haunter_dark),
    "The thing on the door-step" = list(title = "The thing on the door-step", abbreviation = "door", text = lovecraftr::door_step),
    "The festival" = list(title = "The festival", abbreviation = "FE", text = lovecraftr::festival),
    "The lurking fear" = list(title = "The lurking fear", abbreviation = "LURK", text = lovecraftr::lurking),
    "The silver key" = list(title = "The silver key", abbreviation = "key", text = lovecraftr::key),
    "The quest of Iranon" = list(title = "The quest of Iranon", abbreviation = "IRA", text = lovecraftr::iranon),
    "He" = list(title = "He", abbreviation = "HE", text = lovecraftr::he),
    "Cool air" = list(title = "Cool air", abbreviation = "air", text = lovecraftr::air),
    "The Alchemist" = list(title = "The Alchemist", abbreviation = "ALC", text = lovecraftr::alchemist),
    "Azathoth" = list(title = "Azathoth", abbreviation = "AZA", text = lovecraftr::azathoth),
    "The Beast in the Cave" = list(title = "The Beast in the Cave", abbreviation = "BIC", text = lovecraftr::beast_cave),
    "Beyond the Wall of Sleep" = list(title = "Beyond the Wall of Sleep", abbreviation = "BWS", text = lovecraftr::beast_cave),
    "The Book" = list(title = "The Book", abbreviation = "book", text = lovecraftr::book),
    "The Cats of Ulthar" = list(title = "The Cats of Ulthar", abbreviation = "cat", text = lovecraftr::cats),
    "Celephais" = list(title = "Celephais", abbreviation = "C", text = lovecraftr::celephais),
    "Dagon" = list(title = "Dagon", abbreviation = "D", text = lovecraftr::dagon),
    "The Descendant" = list(title = "The Descendant", abbreviation = "DE", text = lovecraftr::descendant),
    "The Doom That Came to Sarnath" = list(title = "The Doom That Came to Sarnath", abbreviation = "DS", text = lovecraftr::doom),
    "The Dream-Quest of Unknown Kadath" = list(title = "The Dream-Quest of Unknown Kadath", abbreviation = "DQ", text = lovecraftr::unknown_kadath),
    "Herbert West Reanimator" = list(title = "Herbert West Reanimator", abbreviation = "HWR", text = lovecraftr::reanimator),
    "The Hound" = list(title = "The Hound", abbreviation = "H", text = lovecraftr::hound),
    "The Music of Erich Zann" = list(title = "The Music of Erich Zann", abbreviation = "MEZ", text = lovecraftr::erich_zann),
    "The Nameless City" = list(title = "The Nameless City", abbreviation = "NC", text = lovecraftr::city),
    "The Outsider" = list(title = "The Outsider", abbreviation = "O", text = lovecraftr::outsider),
    "The Shadow out of Time" = list(title = "The Shadow out of Time", abbreviation = "SOT", text = lovecraftr::shadow_time),
    "The Temple" = list(title = "The Temple", abbreviation = "TE", text = lovecraftr::temple),
    "The Dreams in the Witch House" = list(title = "The Dreams in the Witch House", abbreviation = "DWH", text = lovecraftr::witch_house)

  )

  # If no book is selected, return the list of available stories
  if (is.null(book)) {
    return(data.frame(
      story = names(stories),
      abbreviation = sapply(stories, function(x) x$abbreviation),
      stringsAsFactors = FALSE
    ))
  }

  # Case-insensitive search for the book name or abbreviation
  book_name <- names(stories)[grepl(book, names(stories), ignore.case = TRUE)]
  abbreviation_match <- sapply(stories, function(x) grepl(book, x$abbreviation, ignore.case = TRUE))
  book_name <- c(book_name, names(stories)[abbreviation_match])

  # Remove duplicates if the user matched both the full name and abbreviation
  book_name <- unique(book_name)

  if (length(book_name) == 0) {
    stop("No matching book found. Please check the name or abbreviation.")
  }

  # Return the text of the selected book
  selected_story <- stories[[book_name]]
  return(data.frame(
    text = selected_story$text,
    title = selected_story$title,
    abbreviation = selected_story$abbreviation
  ))
}
