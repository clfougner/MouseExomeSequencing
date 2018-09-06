#!/bin/Rscript

# Chromosome lengths
chromLengths<-read.table(file="/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/mm10chromlengths.txt", header=FALSE, sep="\t")
chromLengths<-data.frame(chromLengths, aggregate=rep(NA, time=length(chromLengths$V1)))

HSLMtable<-read.table(file="/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/AnalysisResults_w20k/Results/S123_14_6/HSLMResults_S123_14_6.txt", header=TRUE, sep="\t")

starts<-c()
ends<-c()

chroms<-paste("chr", c(1:19, "X"), sep="")

for(i in chroms){
  rows<-grep(HSLMtable$Chromosome, pattern=i)
  chromStart <- HSLMtable[rows[1], "Start"]
  chromEnd <- HSLMtable[rows[length(rows)], "End"]
  starts<-c(starts, chromStart)
  ends<-c(ends, chromEnd)
}

totalLength <- sum(ends - starts)

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
  filePath<-paste("/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/AnalysisResults_w20k/Results/", tumors$sampleName[sample], "/FastCallResults_", tumors$sampleName[sample], ".txt", sep="")
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
print(paste("Median CL is:", median(clProps)))
print(paste("Range CL is:", range(clProps)))

print(paste("Mean other is:", mean(otherProps)))
print(paste("Median other is:", median(otherProps)))
print(paste("Range other is:", range(otherProps)))

print(paste("Mean all is:", mean(c(clProps, otherProps))))
print(paste("Median all is:", median(c(clProps, otherProps))))
print(paste("Range all is:", range(c(clProps, otherProps))))
      
t <- t.test(x = clProps, y = otherProps)
print(paste("P-value, mean between CL and other:", t$p.value))

propDF<-data.frame(cluster=c(rep("Claudin-low", times=length(clProps)), rep("Mixed", times = length(otherProps))), proportion = c(clProps, otherProps))

g <- ggplot(propDF, aes(x = cluster, y = proportion, fill = cluster))
chart <- g + geom_boxplot() + 
  geom_jitter(width = 0) +
  scale_fill_manual(values=c('goldenrod3', "dodgerblue4")) +
  labs(x="Cluster", y="Proportion of genome with CNA", fill="") +
  #annotate("text", x = 0.5, y = 0.0225, label = paste("Mean:", substr(mean(clProps), 0,5))) +
  #annotate("text", x = 2.25, y = 0.0225, label = paste("Mean:", substr(mean(otherProps), 0,5))) +
  annotate("text", x = 1.5, y = 0.037, label = paste("P =", substr(t$p.value, 0,5)))
  
print(chart)