#!/bin/Rscript
library(ggplot2)

tumors<-read.table(file="/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/MouseSubtypes.txt", header=FALSE, sep="\t")

sampleNames<-c(as.character(tumors$V1))
sampleNames<-sampleNames[1:17]

clusters<-c(as.character(tumors$V3))
clusters<-clusters[1:17]

# Find tumors in each cluster
CLTumors<-c()
otherTumors<-c()
for (i in 1:length(sampleNames)){
  if (clusters[i] == "CL"){
    CLTumors<-c(CLTumors, sampleNames[i])
  }
  if (clusters[i] == "Other"){
    otherTumors<-c(otherTumors, sampleNames[i])
  }
}

# Make data frame for Claudin low tumors
for (i in 1:length(CLTumors)){
  filePath<-paste("/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/AnalysisResults_w10k/Results/", CLTumors[i], "/HSLMResults_", CLTumors[i], ".txt", sep="")
  data<-read.table(file = filePath, header=TRUE, sep="\t")
  #data<-data[1:100,]

  if (i == 1){
    clDF <- data.frame(chrom = data[, "Chromosome"], position = data[, "Position"], Log2R = data[, "Log2R"])
  }
  
  if (i > 1){
    clDF <- cbind(clDF, Log2R = data[, "Log2R"])
  }
}

colnames(clDF)<-c("chrom", "Position", CLTumors)

mediansCL<-c()
for(i in 1:length(clDF[,"chrom"])){
  medianValue<-median(as.numeric(clDF[i, 3:length(clDF)]))
  mediansCL<-c(mediansCL, medianValue)
}

mediansDF<-data.frame(order=1:length(data$Position), chrom=data[, "Chromosome"], median = mediansCL)


# Make data frame for other cluster
for (i in 1:length(otherTumors)){
  filePath<-paste("/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/AnalysisResults_w10k/Results/", otherTumors[i], "/HSLMResults_", otherTumors[i], ".txt", sep="")
  data<-read.table(file = filePath, header=TRUE, sep="\t")
  #data<-data[1:100,]
  
  if (i == 1){
    otherDF <- data.frame(chrom = data[, "Chromosome"], position = data[, "Position"], Log2R = data[, "Log2R"])
  }
    
  if (i > 1){
    otherDF <- cbind(otherDF, Log2R = data[, "Log2R"])
  }
}

colnames(otherDF)<-c("chrom", "Position", otherTumors)

mediansOther<-c()
for(i in 1:length(otherDF[,"chrom"])){
  medianValue<-median(as.numeric(otherDF[i, 3:length(otherDF)]))
  mediansOther<-c(mediansOther, medianValue)
}

mediansOtherDF<-data.frame(order=1:length(data$Position), chrom=data[, "Chromosome"], median = mediansOther)


#bound<-data.frame(mediansOtherDF[1:100,3:length(mediansOtherDF)], mediansDF[1:100,mediansOtherDF], row.names = mediansOtherDF$)

#dotPlot<-ggplot(mediansDF, aes(x=order, y=median, colour = chrom)) + 
#  geom_point()

library(samr)

set.seed(100)
all <- cbind(otherDF, clDF[, 3:10])

allChromNums<-c()
for(i in 1:length(all$chrom)){
  
  current<-all[i,"chrom"]
  if (nchar(as.character(current)) == 4){
    chromNum <- substr(current, 4, 4)
    if (chromNum == "X"){
      allChromNums <- c(allChromNums, 20)
    } else {
      allChromNums <- c(allChromNums, chromNum)
    }
  }
    
    if (nchar(as.character(current)) == 5){
      chromNum <- substr(current, 4, 5)
      allChromNums <- c(allChromNums, chromNum)
  }
}
all$chrom<-allChromNums


positions <- c()

for (i in 1:length(all$S123_14_6)){
  currentPosition <- paste(all$chrom[i], ":", all$Position[i], sep="")
  print(currentPosition)
  positions <- c(positions, currentPosition)
}

row.names(all)<-NULL
colnames(all) <- NULL

all <- all[,3:19]

outcomes <- c(rep(1, times = 8), rep(2, times = 9))

samResults <- SAM(x = as.matrix(all), y = outcomes, resp.type = "Two class unpaired", geneid = positions, fdr.output=0)
print(str(samResults$siggenes.table))
