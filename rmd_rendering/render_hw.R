# This script attempts to knit all .Rmd inside a specified directory, including
# those inside .zip folders. It produces a "error" vector of the first error
# that stopped the knitting of any files and prints this at the end.
#
# It only knits files that haven't already been knitted, so you can run it
# multiple times on the same folder without fear of redundancy.
#
# NOTE:
# you should think about package conflict in your environment if you run this
# in Rstudio (ex: MASS:select vs dplyr::select).
#
# Created by Brendan McVeigh, extended by Ben LeRoy and Jacqueline Liu

#################
# User settings #
#################

# FILE PATH:
# either specify the file path or pass it in
# as a command line argument

# args <- "C:/Users/ducky/Downloads/submissions"
args <- commandArgs(trailingOnly = TRUE)

# CHECK CODE:
# Comments out certain code (i.e. install.packages calls)
# but tradeoff is it takes more time
code_check <- TRUE

####################
# Helper variables #
####################
setwd(args[1])

# OPERATING SYSTEM:
WINDOWS <- .Platform[['OS.type']] == "windows"

# BAD CODE PATTERNS:
patterns <- c("\ninstall.packages\\(",
              "\nhelp\\(",
              "\n\\?"
              )
replacements <- c("\n# install.packages(",
                  "\n# help\\(",
                  "\n#?"
                  )
any_pattern <- paste(patterns, collapse = "|")
any_pattern <- paste0("(", any_pattern, ")")

# VARIABLES:
filelist <- list.files()
errors <- c()

####################
# Helper functions #
####################

# Checks if the .Rmd file has already been knitted
# by seeing if there is an associated html file
# (basically just guessing the html name)
html_exists <- function(filename) {
  htmlname <- paste0(substr(filename, 1, nchar(filename) - 3), "html")
  return(file.exists(htmlname))
}

# Renders .Rmd files while trying to comment out unnecessary code
# and prints/stores any knitting errors
render_rmd <- function(filename, output_file = NULL, output_dir = args[1]){
  cat("\n", filename, sep = "")

  file <- readChar(filename, file.info(filename)$size)

  # Pattern replacement if desired
  if (code_check && length(grep(any_pattern, file)) > 0) {
    for (i in 1:length(patterns)) {
      file <- gsub(patterns[i], replacements[i], file)
    }
    if (WINDOWS) {
      file <- gsub("\r", "", file) # CRLF vs LF
    }
    write(file, filename)
  }

  # Render report and record any errors
  error <- tryCatch(suppressWarnings(
                      suppressMessages(rmarkdown::render(filename,
                                       envir = new.env(),
                                       output_file = output_file,
                                       output_dir = output_dir,
                                       quiet = TRUE))),
                    error = function(e) {
                              cat('\nError:', e$message)
                              return(e)
                            }
                    )

  if ("error" %in% class(error)) {
    return(paste0(filename, ": ", "contains error", "\n", error$message))
  }
  return(NA)
}

#########################
# Processing .Rmd files #
#########################

for (filename in filelist[grep("[.](?i)rmd$", filelist)]) {
  # Check if file is already knitted - if not, knit
  if (!html_exists(filename)) {
    # Knit file
    error_inner <- render_rmd(filename)
    if (!is.na(error_inner)) {
      errors <- c(errors, error_inner)
    }
  }
}

########################
# Processing Zip files #
########################

for (filename in filelist[grep("[.]zip$", filelist)]) {
  # Unzip and find file
  folder_loc <- strsplit(filename, ".zip")[[1]][1]
  . <- unzip(filename, exdir = folder_loc)
  filelist_inner <- list.files(folder_loc)
  filename_inner <- filelist_inner[grep("[.](?i)rmd$", filelist_inner)]
  filename_outer <- paste0(folder_loc, "_", filename_inner)

  if (!html_exists(filename_outer)) {
    # Knit file
    error_inner <- render_rmd(paste0(folder_loc, "/", filename_inner),
                              output_file = paste0(substr(filename_outer,
                                                          1,
                                                          nchar(filename_outer) - 3),
                                                   "html"))
    if (!is.na(error_inner)) {
      errors <- c(errors, error_inner)
    }
  }
}

##########################
#   Printing out Errors  #
# (and associated files) #
##########################

for (string_v in errors) {
  cat("\n\n")
  cat(string_v)
  cat("\n\n\n")
}
