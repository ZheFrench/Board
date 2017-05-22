ChIPSEQ Analysis
================
Jean-Philippe Villemin aka ZheFrench
May 22, 2017

``` {.r}
suppressMessages(library(chipseq))
```

    ## Warning: package 'BiocGenerics' was built under R version 3.3.3

    ## Warning: package 'S4Vectors' was built under R version 3.3.3

    ## Warning: package 'IRanges' was built under R version 3.3.3

    ## Warning: package 'GenomicRanges' was built under R version 3.3.3

    ## Warning: package 'GenomeInfoDb' was built under R version 3.3.3

    ## Warning: package 'ShortRead' was built under R version 3.3.3

    ## Warning: package 'BiocParallel' was built under R version 3.3.3

    ## Warning: package 'Biostrings' was built under R version 3.3.3

    ## Warning: package 'XVector' was built under R version 3.3.3

    ## Warning: package 'Rsamtools' was built under R version 3.3.3

    ## Warning: package 'GenomicAlignments' was built under R version 3.3.3

    ## Warning: package 'SummarizedExperiment' was built under R version 3.3.3

    ## Warning: package 'Biobase' was built under R version 3.3.3

``` {.r}
suppressMessages(library(ChIPQC))
```

    ## Warning: package 'ggplot2' was built under R version 3.3.2

``` {.r}
suppressMessages(library(DiffBind))
suppressMessages(library(chromstaR))
suppressMessages(library(ChIPseeker))
suppressMessages(library(rtracklayer))
library(rmarkdown)
library(knitr)
# 'First we set up some options (you do not have to do this):


opts_chunk$set(fig.path = 'figure/silk-')

# 'The report begins here.

# boring examples as usual
set.seed(123)
x = rnorm(5)
mean(x)
```

    ## [1] 0.1935703

``` {.r}
# render("chip.R",output_format="github_document")
# Rscript chip.R -e "rmarkdown::render('chip.Rmd','github_document')"
```
