.PHONY: all clean part1 part2 part3

vpath %.R R
vpath %.py python
vpath %.txt raw
vpath %.png img


all: part1 part2 part3 README.md

clean:
	del /s /q *.txt *.tsv *.png *.html *.md *.pdf

part1: report.html

report.html: report.rmd histogram.tsv histogram.png
	Rscript -e 'rmarkdown::render("$<")'

histogram.png: histogram.tsv
	Rscript -e 'library(ggplot2); qplot(Length, Freq, data=read.delim("data/$<")); ggsave("img/$@")'
	del /s /q Rplots.pdf

histogram.tsv: histogram.R words.txt
	Rscript $< raw/$(word 2,$^) data/$@

words.txt:
	Rscript -e 'download.file("http://svnweb.freebsd.org/base/head/share/dict/web2?view=co", \
														destfile = "raw/$@", quiet = TRUE)'

part2: report2.html

letter_freq.tsv: letter_freq.R words.txt
	Rscript $< raw/$(word 2,$^) data/$@
	
letter_head.tsv: letter_head.R words.txt
	Rscript $< raw/$(word 2,$^) data/$@
	
letter_tail.tsv: letter_tail.R words.txt
	Rscript $< raw/$(word 2,$^) data/$@
	
letter_freq.png: letter_freq.tsv
	Rscript -e 'library(ggplot2); qplot(freq, Freq, data=read.delim("data/$<")); ggsave("img/$@")'
	del /s /q Rplots.pdf

letter_head.png: letter_head.tsv
	Rscript -e 'library(ggplot2); qplot(head, Freq, data=read.delim("data/$<")); ggsave("img/$@")'
	del /s /q Rplots.pdf

letter_tail.png: letter_tail.tsv
	Rscript -e 'library(ggplot2); qplot(tail, Freq, data=read.delim("data/$<")); ggsave("img/$@")'
	del /s /q Rplots.pdf

report2.html: report2.rmd letter_freq.tsv letter_head.tsv letter_tail.tsv letter_freq.png letter_head.png letter_tail.png
	Rscript -e 'rmarkdown::render("$<")'


part3: dependencyplot.png dependencyplotR.png

dependencyplotR.png: visual_makefile.R Makefile
	Rscript $< img/$@
	
dependencyplot.png: makefile2dot.py
	python $< <Makefile |dot -Tpng > img/$@

README.md: README.Rmd
	Rscript -e 'rmarkdown::render("$<")'

