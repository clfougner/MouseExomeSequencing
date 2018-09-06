#!/bin/bash

tumors<-read.table(file="/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/MouseSubtypes.txt", header=FALSE, sep="\t")
colnames(tumors) <- c("sampleName", "subtype", "cluster")

allSegmentCounts <- c()

for (sample in 1:length(tumors$sampleName)){
  filePath<-paste("/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/AnalysisResults_w50k/Results/", tumors$sampleName[sample], "/FastCallResults_", tumors$sampleName[sample], ".txt", sep="")
  fastCallResults<-read.table(file = filePath, header=TRUE, sep="\t")
  counts <- length(fastCallResults$Chromosome)
  allSegmentCounts <- c(allSegmentCounts, counts)
}


tumors <- cbind(tumors, nCNAsegments = allSegmentCounts)

clSegmentCounts <- c()
otherSegmentCounts <- c()

for (i in 1:length(tumors$sampleName)){
  
  if (is.na(tumors[i, "cluster"])){
    next
  }
  
  if (tumors[i, "cluster"] == "CL"){
    clSegmentCounts  <- c(clSegmentCounts , tumors[i, "nCNAsegments"])
  }
  
  if (tumors[i, "cluster"] == "Other"){
    otherSegmentCounts  <- c(otherSegmentCounts , tumors[i, "nCNAsegments"])
  }
}

print(paste("Mean CL is:", mean(clSegmentCounts)))
print(paste("Mean other is:", mean(otherSegmentCounts)))
t <- t.test(x = clSegmentCounts, y = otherSegmentCounts)
print(paste("P-value is:", t$p.value))