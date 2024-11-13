## script to download the necessary HP lovecraft books


library(gutenbergr)
library(readr)

remove_illustrations_and_stars <- function(text_vector) {
  # Find the indices of the elements containing [Illustration:
  start_indices <- grep("\\[Illustration:", text_vector)

  # Initialize a vector to mark elements to be removed
  to_remove <- rep(FALSE, length(text_vector))

  # Loop over each start index and mark all relevant elements to be removed
  for (start in start_indices) {
    # Mark the starting element
    to_remove[start] <- TRUE

    # Find the end index for the [Illustration: block
    # Look ahead for the next closing bracket ] that marks the end of the block
    for (i in (start + 1):length(text_vector)) {
      to_remove[i] <- TRUE
      if (grepl("]", text_vector[i])) {
        break
      }
    }
  }

  # Remove the marked elements
  cleaned_text_vector <- text_vector[!to_remove]

  # Remove any "*" pattern remaining in the text
  cleaned_text_vector <- gsub("\\*\\s*\\*\\s*\\*\\s*\\*\\s*\\*", "", cleaned_text_vector)

  return(cleaned_text_vector)
}



call_of_cthulhu <- gutenberg_download(68283,
                                      mirror = "http://mirror.csclub.uwaterloo.ca/gutenberg")$text
# remove notes from original printing not made by lovecraft
call_of_cthulhu <- call_of_cthulhu[-c(5:30)]

mountain_madness <- gutenberg_download(70652)$text
mountain_madness <- mountain_madness[-c(4:9)]

dunwich_horror <- gutenberg_download(50133,
                                     mirror = "http://mirror.csclub.uwaterloo.ca/gutenberg")$text
dunwich_horror <- dunwich_horror[-c(6:22,923,1519)]

colour_space <- gutenberg_download(68236,
                                   mirror = "http://mirror.csclub.uwaterloo.ca/gutenberg")$text

colour_space <- colour_space[-c(5:18)]

shadow_innsmouth <- read_lines("https://www.gutenberg.org/cache/epub/73181/pg73181.txt", skip = 30)
shadow_innsmouth <- shadow_innsmouth[-c(8:17,1722:length(shadow_innsmouth))]

shunned_house <- gutenberg_download(31469)$text
shunned_house <- shunned_house[-c(6:20)]

charles_dexter <- read_lines("https://www.gutenberg.org/cache/epub/73547/pg73547.txt", skip = 30)
charles_dexter <- charles_dexter[-c(5:42)]
charles_dexter <- charles_dexter[-c(4400:length(charles_dexter))]


red_hook <- read_lines("https://www.gutenberg.org/cache/epub/72966/pg72966.txt", skip = 33)
red_hook <- red_hook[-c(874:length(red_hook))]

# function to remove illustrations and seperation *****
call_of_cthulhu <- remove_illustrations_and_stars(call_of_cthulhu)
mountain_madness <- remove_illustrations_and_stars(mountain_madness)
colour_space <- remove_illustrations_and_stars(colour_space)
shadow_innsmouth <- remove_illustrations_and_stars(shadow_innsmouth)
shunned_house <- remove_illustrations_and_stars(shunned_house)
charles_dexter <- remove_illustrations_and_stars(charles_dexter)
red_hook <- remove_illustrations_and_stars(red_hook)


## use data internally

use_data(call_of_cthulhu, overwrite = TRUE)
use_data(mountain_madness, overwrite = TRUE)
use_data(colour_space, overwrite = TRUE)
use_data(shadow_innsmouth, overwrite = TRUE)
use_data(shunned_house, overwrite = TRUE)
use_data(charles_dexter, overwrite = TRUE)
use_data(red_hook, overwrite = TRUE)
use_data(dunwich_horror, overwrite = TRUE)
