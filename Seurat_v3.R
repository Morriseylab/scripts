library(Seurat)
library(dplyr)
library(cowplot)
library(scExtras)



####################### Global Vars ############################
outdir<-'Seurat' # All results will be saved here plots, RData file 
projectname<-'LAM' # specify project name,this will also be the Rdata file name
input10x <- c('LAM_rep1/filtered_feature_bc_matrix/','LAM_rep2/filtered_feature_bc_matrix') # dir(s) of the 10x output files, genes.tsv,barcodes.tsv
org<-'human' 

mouseorthologfile <- '~/NGSshare/homologs/mouse_human.csv'
npcs<-50 #How many inital PC dimensions to compute. 
k=30 #This for nearest neighbors, 30 is default

#system(paste0("zcat filtered_feature_bc_matrix/barcodes.tsv.gz | wc -l"))


################################################################
## Preprocess the data and create a seurat object
dir.create(outdir,recursive = T)
scrna <- processExper(dir=outdir,org=org,name=projectname,files=input10x ,ccscale = T,filter=T)
scrna <- ClusterDR(scrna,npcs=npcs,maxdim='auto',k=k)

pdf(file="Elbowplot.pdf")
ElbowPlot(scrna, ndims = 50)
dev.off()

for(l in seq(0,(maxdim %/%20-1)*20,20)+1){
  h=ifelse(l+19>=maxdim,maxdim,l+19)
  pdf(file=paste("pcheatmap_",l,"_",h,".pdf",sep=""),height = 18,width = 11)
  DimHeatmap(object = scrna, dims = l:h, cells = 500)
  dev.off()
}

pdf("jackstraw.pdf", width=15, height =10)
JackStrawPlot(scrna, dims=1:50)
dev.off()

#IF required rerun ClusterDR with different dims

scrna= ligrec(object=scrna,org=org)
saveRDS(scrna,file=paste0("VK_",projectname,'.RDS'))
