#!/bin/Rscript
library(ggplot2)

# First run AmpDelHeatmapAllChroms.R

tumors<-read.table(file="/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/MouseSubtypes.txt", header=FALSE, sep="\t")
colnames(tumors) <- c("sampleName", "subtype", "cluster")

clTumors<-c()
otherTumors<-c()
for (i in 1:length(tumors$sampleName)){
  if(is.na(tumors[i, "cluster"])){
    next
  }
  
  if (tumors[i, "cluster"] == "CL"){
    sampleName <- as.character(tumors[i, "sampleName"])
    clTumors<-c(clTumors, sampleName)
  }
  
  if (tumors[i, "cluster"] == "Other"){
    sampleName <- as.character(tumors[i, "sampleName"])
    otherTumors<-c(otherTumors, sampleName)
  }
}

clDF <- allDF[, clTumors]
otherDF <- allDF[, otherTumors]

getCNAproportions<-function(x){
  ampProp<-c()
  delProp<-c()
  for (i in 1:length(x[,1])){
    rowAmps <- 0
    rowDels <- 0
    for (n in 1:length(x)){
      if (x[i,n] > 0){
        rowAmps <- rowAmps + 1
      }
      
      if (x[i,n] < 0){
        rowDels <- rowDels - 1
      }
    }
  
  rowAmpProp <- rowAmps/length(x)
  ampProp <- c(ampProp, rowAmpProp)
  rowDelProp <- rowDels/length(x)
  delProp <- c(delProp, rowDelProp)
  }
  return(data.frame(ProportionAmps = ampProp, ProportionDels = delProp))
}

clDF<-cbind(clDF, getCNAproportions(clDF))
otherDF<-cbind(otherDF, getCNAproportions(otherDF))
allDF<-cbind(allDF, getCNAproportions(allDF))

makeLong <- function(x){
  positionNames <- c(row.names(x), row.names(x))
  CNA_type <- c(rep("amp", times=length(row.names(x))), rep("del", times=length(row.names(x))))
  CN_proportion <- c(x[, "ProportionAmps"], x[, "ProportionDels"])
  return(data.frame(position = positionNames, type = CNA_type, prop = CN_proportion))
}

clDF_long <- makeLong(clDF)
otherDF_long <- makeLong(otherDF)
allDF_long <- makeLong(allDF)

ggplot(allDF_long) + geom_bar(aes(x=position, y=prop, fill=type), stat="identity", width=1) +
    theme(
      axis.text.x = element_blank(),
      axis.ticks.x = element_blank()
    ) +
  scale_fill_manual(values=c('red', "blue"), na.value='grey85', name='CNAs')

