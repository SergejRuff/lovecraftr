#' @title Fetch Lovecraft's Stories from the H.P. Lovecraft Archive
#'
#' @description
#' The `fetch_lovecraft` function retrieves text from stories by H.P. Lovecraft from the H.P. Lovecraft Archive.
#' If no URL is provided, it returns a data frame listing all available stories with download links.
#' If a valid URL is given, it fetches and returns the text from that specific story.
#'
#' @param url A character string containing the URL of a specific H.P. Lovecraft story.
#'            If `NULL`, the function returns a list of available stories and their links.
#' @param trim A vector of indices specifying which lines of the text to keep/trim.
#'             If `NULL`, all lines of the text are returned.
#'
#' @return
#' If a valid URL is provided, the function returns a data frame with two columns:
#'
#'  \describe{
#'   \item{text}{A vector containing the story's text split into lines.}
#'     \item{title}{The title of the story.}
#'   }
#'   If no URL is provided, the function returns a data frame with two columns:
#'   \describe{
#'     \item{name}{The name of the story.}
#'     \item{link}{The URL from which the story can be downloaded.}
#'   }
#'
#' @references \emph{H.P. Lovecraft Archive}: \url{https://www.hplovecraft.com/}.
#' @examples
#'
#' \donttest{
#'
#' #' # List all available stories
#' fetch_lovecraft()
#'
#' # Retrieve a story
#' fetch_lovecraft("https://www.hplovecraft.com/writings/texts/fiction/mm.aspx")
#'
#' }
#'
#'
#' @importFrom rvest read_html html_text html_node html_attr html_nodes
#' @importFrom stringr str_extract
#' @importFrom magrittr %>%
#' @export
fetch_lovecraft <- function(url=NULL,trim=NULL){

  # Check if URL is not NULL and contains the specific substring
  if (!is.null(url) && grepl("https://www.hplovecraft.com/writings/texts/", url)) {

    tryCatch({
      # Read HTML content from the URL
      html_content <- read_html(url)

      title <- html_content %>% html_nodes("title") %>% html_text()

      title <- str_extract(title, '(?<=^").*?(?=")')

      # Extract plain text as a single string
      plain_text <- html_text(html_content %>% html_node('div[align="justify"]'))

      # Split the plain text into individual lines (or paragraphs) based on newlines
      text_vector <- strsplit(plain_text, split = "\n")[[1]]

      # Optionally trim the text_vector
      if (!is.null(trim)) {
        text_vector <- text_vector[trim]
      }

      # Check if text_vector contains no text
      if (length(text_vector) == 0 || all(nchar(trimws(text_vector)) == 0)) {
        message(sprintf("No story found at URL: %s. Skipping to the next.", url))
        return(NULL)
      }

      # Return the extracted text
      return(data.frame(
        text = text_vector,
        title = title))

    }, error = function(e) {
      message(sprintf("An error occurred while processing URL: %s. Skipping to the next.", url))
      return(NULL)
    })

  } else {

    message(
      "The function `fetch_lovecraft` returns a data frame with available titles by H.P. Lovecraft. ",
      "Each title includes a corresponding download link from the H.P. Lovecraft Archive: ",
      "https://www.hplovecraft.com/"
    )

    list_of_texts <- read_html("https://www.hplovecraft.com/writings/texts/")

    link_prefix <- list_of_texts %>%
      html_nodes("ul li a") %>%
      html_attr("href")

    text_names <- list_of_texts %>%
      html_nodes("ul li a") %>% html_text()


    text_names <- text_names[!is.na(link_prefix)]

    link_prefix <- link_prefix[!is.na(link_prefix)]

    complete_list <- data.frame(
      name= text_names,
      link = paste0("https://www.hplovecraft.com/writings/texts/",link_prefix)
    )

    return(complete_list)

  }


}

