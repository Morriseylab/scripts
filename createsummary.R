library(data.table)
library(dplyr)
library(readr)
#install.packages("bit64")
#require(bit64)
library(tidyr)
args = commandArgs(trailingOnly=TRUE)
createsummary <- function(directory) {
  print(directory)
setwd(directory)

resdir=paste(directory,'/results',sep="")
dir='STAR'

#get file list
(file_list <- list.files(dir,pattern=".libcomplex$",full.names=T))

#check if files are empty
info=file.info(file_list)
file_list=file_list[info$size!=0]
######################
setwd("..")
pData=read.csv("data/phenodata.csv")
(head(pData))
setwd(directory)
######################
df<-  data.frame()
#names(file) <-n
for(i in 1:length(file_list)){
  f1=read_delim(file_list[i],delim="\t")
  k=strsplit(file_list[i],"/")
  n=sapply(k,"[",2)
  k2=strsplit(n,"[.]")
  n2=sapply(k2,"[",1)
  f1$id=n2
  df=rbind(df,f1)
}

rownames(df)=df$id
df=df%>% select(-id)
df$Sample=rownames(df)
write.csv(df,file=paste(resdir,"/libcomplex.csv",sep=''))

######################
file_list <- list.files(dir,pattern=".metrics$",full.names=T)
info2=file.info(file_list)
file_list=file_list[info2$size!=0]
df2<-  data.frame()
#names(file) <-n
for(i in 1:length(file_list)){
  f1=read_delim(file_list[i],delim="\t")
#    f1$UTR_BASES=as.integer64(f1$UTR_BASES)
#    f1$INTRONIC_BASES=as.integer(f1$INTRONIC_BASES)
#   f1$PF_ALIGNED_BASES=as.numeric(f1$PF_ALIGNED_BASES)
#   f1$CODING_BASES=as.numeric(f1$CODING_BASES)
  k=strsplit(file_list[i],"/")
  n=sapply(k,"[",2)
  k2=strsplit(n,"[.]")
  n2=sapply(k2,"[",1)
  f1$id=n2
  df2=rbind(df2,f1)
}

rownames(df2)=df2$id
df2=df2%>% select(-id)
write.csv(df2,file=paste(resdir,"/metrics.csv",sep=''))

######################
file_list <- list.files(dir,pattern=".mrkdup$",full.names=T)
info3=file.info(file_list)
file_list=file_list[info3$size!=0]
df3<-  data.frame()
#names(file) <-n
for(i in 1:length(file_list)){
  f1=read_delim(file_list[i],delim="\t")
  k=strsplit(file_list[i],"/")
  n=sapply(k,"[",2)
  k2=strsplit(n,"[.]")
  n2=sapply(k2,"[",1)
  f1$id=n2
  df3=rbind(df3,f1)
}

rownames(df3)=df3$id
df3=df3%>% dplyr::select(-id)
write.csv(df3,file=paste(resdir,"/markdup.csv",sep=''))

######################
prjname=tail(strsplit(directory,split="/")[[1]],1)
starsumm=read.csv(paste(resdir,"/STAR_summmary.csv",sep=""))
STAR=list(starsummary=starsumm,libcomplex=df,metrics=df2,markdups=df3,pData=pData)
save(STAR,file=paste(resdir,"/",prjname,"_starsumm.RData",sep=''))
}
createsummary(directory=args[1])