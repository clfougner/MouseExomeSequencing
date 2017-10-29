#!/bin/Rscript

# Chromosome lengths
chromLengths<-read.table(file="/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/mm10chromlengths.txt", header=FALSE, sep="\t")
chromLengths<-data.frame(chromLengths, aggregate=rep(NA, time=length(chromLengths$V1)))

totalLength <- sum(as.numeric(chromLengths$V2))

tumors<-read.table(file="/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/MouseSubtypes.txt", header=FALSE, sep="\t")
colnames(tumors) <- c("sampleName", "subtype", "cluster")

findProportion <- function(file){
  fastCallResults<-read.table(file = filePath, header=TRUE, sep="\t")
  nBases <- c()
  for (n in 1:length(fastCallResults$Chromosome)){
    significant <- as.numeric(fastCallResults[n, "ProbCall"]) > 0.95
    if (significant){
      start <- fastCallResults[n, "Start"]
      end <- fastCallResults[n, "End"]
      segLength <- end - start
      nBases <- c(nBases, segLength)
    }
  }
  ampDelBases <- sum(nBases)
  prop <- ampDelBases/totalLength
  return(prop)
}

allProportions <- c()
for (sample in 1:length(tumors$sampleName)){
  filePath<-paste("/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/AnalysisResults_w50k/Results/", tumors$sampleName[sample], "/FastCallResults_", tumors$sampleName[sample], ".txt", sep="")
  proportion <- findProportion(file = filePath)
  allProportions <- c(allProportions, proportion)
}

tumors <- cbind(tumors, CNA_proportion = allProportions)

clProps <- c()
otherProps <- c()

for (i in 1:length(tumors$sampleName)){
  if (is.na(tumors[i, "cluster"])){
    next
  }
  
  if (tumors[i, "cluster"] == "CL"){
    clProps <- c(clProps, tumors[i, "CNA_proportion"])
  }
  
  if (tumors[i, "cluster"] == "Other"){
    otherProps <- c(otherProps, tumors[i, "CNA_proportion"])
  }
}
print(paste("Mean CL is:", mean(clProps)))
print(paste("Mean other is:", mean(otherProps)))
t <- t.test(x = clProps, y = otherProps)
print(paste("P-value is:", t$p.value))
