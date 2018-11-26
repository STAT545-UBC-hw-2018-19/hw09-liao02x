library(igraph)
library(stringr)
library(dplyr)

args <- commandArgs(T)

## Read makefile and find relevant lines
dep <- readLines("Makefile") %>%
	unlist() %>% 
	str_extract("^[^\\s].*:\\s.*") %>%
	na.omit()

## Parse the sentences to targets and depends
target <- gsub(":.*", "", dep)
depends <- gsub(".*:", "", dep) %>%
	strsplit(" ")
names(depends) <- target

## Create the dependency graph
dlist <- lapply(target, function(t) {
	d <- if(length(depends[[t]]) == 0) NA else depends[[t]]
	data.frame(depends = d, target = t)
})
dependencygraph <- na.omit(do.call("rbind", dlist)) %>%
	filter(depends != "") %>%
	graph.data.frame()

## Make the plot
png(filename=args[1], units = "px", width = 1000, height = 1000, res = 100)
dependencygraph %>%
{
	plot(.,
			 layout = layout_with_dh(., weight.edge.lengths = 0),
			 vertex.shape = "rectangle", 
			 vertex.size = 30, 
			 vertex.color = "yellow",
			 edge.arrow.size = 1,
			 cex = 0.3
	)
}
dev.off()
