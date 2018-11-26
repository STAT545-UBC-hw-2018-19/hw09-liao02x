library(dplyr)
library(stringr)

args <- commandArgs(T)
words <- readLines(args[1]) %>%
	str_to_lower()

#count first letter freq
head <- words %>%
	lapply(function(x) substr(x, 1, 1)) %>%
	unlist() 
letter_head <- table(head)

write.table(letter_head, args[2],
						sep = "\t", row.names = FALSE, quote = FALSE)
