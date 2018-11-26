args <- commandArgs(T)
words <- readLines(args[1])
Length <- nchar(words)
hist_dat <- table(Length)
write.table(hist_dat, args[2],
						sep = "\t", row.names = FALSE, quote = FALSE)
