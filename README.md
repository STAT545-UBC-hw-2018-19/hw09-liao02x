---
title: "STAT545 HW09 Makefile"
output:
  html_document:
    keep_md: yes
---

This repo is for STAT545 homework 09 makefile activity by Minzhi Liao.

The whole project is built by this [Makefile](https://github.com/STAT545-UBC-students/hw09-liao02x/blob/master/Makefile).

For those who are interested, I also commit once when the whole project is built up. So if you want to see that, the link is here: 
[hw09-liao02x](https://github.com/STAT545-UBC-students/hw09-liao02x/tree/ea95fbfc3714ec508a9ad8134da03d8e0b3d82b5).

The rendered html outputs of the project are here: [report.html](https://raw.githack.com/STAT545-UBC-students/hw09-liao02x/master/report.html) and 
[report2.html](https://raw.githack.com/STAT545-UBC-students/hw09-liao02x/master/report2.html).

## How to build the project
You can build the whole project by simply run:

```
make all
```

But you'll need R and python with all dependent packages to actually run through the building process.

**Also notice that for running on windows, I modified Makefile in some ways like change `rm -f` to `del /s /q`, so it is only available on windows now.**

## Visualization of Makefile

The python script [makefile2dot.py](https://github.com/STAT545-UBC-students/hw09-liao02x/blob/master/python/makefile2dot.py) is modified from 
[here](https://github.com/vak/makefile2dot) to add color support for different file types.
The dependency plot is shown below:

![](https://github.com/STAT545-UBC-students/hw09-liao02x/blob/master/img/dependencyplot.png)

Also I tried some visualization myself with R package `igraph`, but the layout of the output image is very strange. Anyway it is shown here:

![](https://github.com/STAT545-UBC-students/hw09-liao02x/blob/master/img/dependencyplotR.png)

## The structure of this repo

The R script files are in [R](https://github.com/STAT545-UBC-students/hw09-liao02x/tree/master/R), 
and I also use python script in [python](https://github.com/STAT545-UBC-students/hw09-liao02x/tree/master/python) to visualize Makefile.
The structure is shown below:
  * [data](https://github.com/STAT545-UBC-students/hw09-liao02x/tree/master/data): for `.tsv` files
  * [raw](https://github.com/STAT545-UBC-students/hw09-liao02x/tree/master/raw): for `.txt` files
  * [img](https://github.com/STAT545-UBC-students/hw09-liao02x/tree/master/img): for `.png` pictures
  * [R](https://github.com/STAT545-UBC-students/hw09-liao02x/tree/master/R)
    - [histogram.R](https://github.com/STAT545-UBC-students/hw09-liao02x/blob/master/R/histogram.R): origin file
    - [letter_freq.R](https://github.com/STAT545-UBC-students/hw09-liao02x/blob/master/R/letter_freq.R): R script for calculating letter frequency
    - [letter_head.R](https://github.com/STAT545-UBC-students/hw09-liao02x/blob/master/R/letter_head.R): R script for calculating head letter frequency
    - [letter_tail.R](https://github.com/STAT545-UBC-students/hw09-liao02x/blob/master/R/letter_tail.R): R script for calculating tail letter frequency
    - [visualize_makefile.R](https://github.com/STAT545-UBC-students/hw09-liao02x/blob/master/R/visual_makefile.R): R script for visualize Makefile somehow with R
  * [python](https://github.com/STAT545-UBC-students/hw09-liao02x/tree/master/python)
    - [makefile2dot.py](https://github.com/STAT545-UBC-students/hw09-liao02x/blob/master/python/makefile2dot.py): modified from [here](https://github.com/vak/makefile2dot) to assign different color for different file types
  * [report.Rmd](https://github.com/STAT545-UBC-students/hw09-liao02x/blob/master/report.rmd): origin file
  * [report2.Rmd](https://github.com/STAT545-UBC-students/hw09-liao02x/blob/master/report2.Rmd): additional report for further analysis on the `words.txt`
  * [README.Rmd](https://github.com/STAT545-UBC-students/hw09-liao02x/blob/master/README.Rmd): building `README.md` file for this repo
