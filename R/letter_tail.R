library(dplyr)
library(stringr)

args <- commandArgs(T)
words <- readLines(args[1]) %>%
	str_to_lower()

#count last letter freq
tail <- words %>%
	lapply(function(x) substr(x, nchar(x), nchar(x))) %>%
	unlist() 
letter_tail <- table(tail)

write.table(letter_tail, args[2],
						sep = "\t", row.names = FALSE, quote = FALSE)