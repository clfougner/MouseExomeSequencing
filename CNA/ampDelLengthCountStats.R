tumors<-read.table(file="/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/MouseSubtypes.txt", header=FALSE, sep="\t")
colnames(tumors) <- c("sampleName", "subtype", "cluster")

ampCount <- c()
ampLengths <- c()
delCount <- c()
delLengths <- c()

for (sample in 1:length(tumors$sampleName)){
  
  filePath<-paste("/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/AnalysisResults_w20k/Results/", tumors$sampleName[sample], "/FastCallResults_", tumors$sampleName[sample], ".txt", sep="")
  fastCallResults<-read.table(file = filePath, header=TRUE, sep="\t")
  
  nBasesAmps <- c()
  nBasesDels <- c()
  
  for (n in 1:length(fastCallResults$Chromosome)){  
    significant <- as.numeric(fastCallResults[n, "ProbCall"]) > 0.00
    if (significant){
      if(fastCallResults[n, "Call"] > 0){
        start <- fastCallResults[n, "Start"]
        end <- fastCallResults[n, "End"]
        segLength <- end - start
        nBasesAmps <- c(nBasesAmps, segLength)
      }
      if(fastCallResults[n, "Call"] < 0){
        start <- fastCallResults[n, "Start"]
        end <- fastCallResults[n, "End"]
        segLength <- end - start
        nBasesDels <- c(nBasesDels, segLength)
      }
    }
  }
  
  ampCount <- c(ampCount, length(nBasesAmps))
  delCount <- c(delCount, length(nBasesDels))
  ampLengths <- c(ampLengths, nBasesAmps)
  delLengths <- c(delLengths, nBasesDels)
  
}

print(paste("Mean number of amplifications:", mean(ampCount)))
print(paste("Median number of amplifications:", median(ampCount)))
print(paste("Range in number of amplifications:", min(ampCount), "-", max(ampCount)))
print(paste("Mean amplification length:", as.integer(mean(ampLengths))))
print(paste("Median amplification length:", as.integer(median(ampLengths))))

print(paste("Mean number of deletions:", mean(delCount)))
print(paste("Median number of deletions:", median(delCount)))
print(paste("Range in number of deletions", min(delCount), "-", max(delCount)))
print(paste("Mean deletion length:", as.integer(mean(delLengths))))
print(paste("Median deletion length:", as.integer(median(delLengths))))
  
