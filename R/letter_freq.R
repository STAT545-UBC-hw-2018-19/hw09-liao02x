library(dplyr)
library(stringr)

args <- commandArgs(T)
words <- readLines(args[1]) %>%
	str_to_lower()

# count all letter freq
freq <- words %>%
	strsplit("") %>%
	unlist()
letter_freq <- table(freq)


write.table(letter_freq, args[2],
						sep = "\t", row.names = FALSE, quote = FALSE)
