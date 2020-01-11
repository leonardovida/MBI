#! /usr/bin/env Rscript

#mapper in r

fi <- file("stdin", open = "r")

while (length(line <- readLines(fi, n=1, warn = FALSE)) > 0) {
  #remove new lines and carriage return
  line <- gsub("[\r\n]", "", line)
  
  #split the text on blank spaces
  line_splitted <-  unlist(strsplit(line, " "))
  
  for (x in line_splitted)
    cat (x, "\t1\n", sep="")
}
close(fi)

#! /usr/bin/env Rscript

#reducer in r

splitline <- function(line) {
  #redo to be used in the environment
  stripped <- unlist(strsplit(line, "\t"))
  list(key = stripped[1], value = as.integer(stripped[2]))
}

#using environments was NOT my own idea
env <- new.env(hash = TRUE)

con <- file("stdin", open = "r")
while (length(line <- readLines(con, n = 1, warn = FALSE)) > 0) {
  
  line <- gsub("[\r\n]", "", line)
  line_splitted <-  unlist(strsplit(line, " "))
  
  key <- split$key
  value <- split$value
  if (exists(key, envir = env)) {
    #if key/word already present than take old count and add 1
    oldcount <- get(key, envir = env)
    assign(key, oldcount + value, envir = env)
  }
  #else if key not present then it's ok like this
  else assign(key, value)
}

