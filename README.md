# Scripts
RScripts and codes for analysis

## Files

### R scripts
- Microarray_pipeline.R     : Microarray analysis pipeline
- RNAseqAnalysisPipeline.R  : RNA-Seq analysis pipeline
- scRNA_seurat_pipeline.R   : Single cell RNA-Seq analysis pipeline using Seurat
- aggr_seurat_cca.R         : Single cell RNA-Seq analysis for aggregate data pipeline using Seurat

### Run STAR
- run_STAR_singlepass.pl    : Run STAR aligner on fastq files
- parseSTARLog.pl           : Read STAR Log.out files to create a summary of results
- createsummary.R           : Create STAR and Picard summary files into RData file to upload into STARSummary [website](https://github.com/Morriseylab/STARSummary)

## Requirements
### Install following R packages. 
#### MICROARRAY
```
install.packages(c("dplyr","plyr","tidyr","devtools","NMF","RColorBrewer","ggplot2","readr"))

## try http:// if https:// URLs are not supported
source("https://bioconductor.org/biocLite.R")
biocLite(c("OligoTools","sva","limma","SPIA","oligo","topGO"))

#Install this package having additional functions
install_github('mpmorley/ExpressExtras')

```
#### RNA_Seq
```
install.packages(c("dplyr","plyr","tidyr","devtools","NMF","RColorBrewer","ggplot2","readr"))

## try http:// if https:// URLs are not supported
source("https://bioconductor.org/biocLite.R")
biocLite(c("limma","edgeR","org.Mm.eg.db","EnsDb.Mmusculus.v75","SPIA"))

#Install this package having additional functions
install_github('mpmorley/ExpressExtras')

```
#### Single Cell RNA-Seq using Seurat
```
install.packages(c("dplyr","readr","Matrix","cowplot"))

## try http:// if https:// URLs are not supported
source("https://bioconductor.org/biocLite.R")
biocLite("Seurat")
```
### STAR
Install and run STAR aligner. Instructions and documentation can be found [here.](http://labshare.cshl.edu/shares/gingeraslab/www-data/dobin/STAR/STAR.posix/doc/STARmanual.pdf)

## NOTE:
- The RNA-Seq and Microarray scripts are written for data aligned using STAR. You have to edit the code for it to take an input of count data
- The R scripts for analysing Microarray and RNA-Seq data requires a file listing the sample names and other meta-information. Please refer to the example file in data folder titled 'phenodata.csv'. 
- If you want to use a file for specifying contrasts instead of adding it to the script, refer to the file in the data folder titled 'contrastlist.csv'

