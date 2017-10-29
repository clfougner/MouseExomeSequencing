#!/bin/Rscript

tumors<-read.table(file="/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/MouseSubtypes.txt", header=FALSE, sep="\t")
colnames(tumors) <- c("sampleName", "subtype", "cluster")

nGenesMut <- c()

for (sample in 1:length(tumors$sampleName)){
  filePath<-paste("/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/AnalysisResults_w50k/Intersect/", tumors$sampleName[sample], "_CNA_0.95_annotated.txt", sep="")
  genes<-read.table(file = filePath, header=TRUE, sep="\t")
  nGenes <- length(unique(genes$geneName))
  nGenesMut <- c(nGenesMut, nGenes)
}

tumors <- cbind(tumors, nMutGenes = nGenesMut)

clNumGenes <- c()
otherNumGenes <- c()

for (i in 1:length(tumors$sampleName)){
  
  if (is.na(tumors[i, "cluster"])){
    next
  }
  
  if (tumors[i, "cluster"] == "CL"){
    clNumGenes <- c(clNumGenes, tumors[i, "nMutGenes"])
  }
  
  if (tumors[i, "cluster"] == "Other"){
    otherNumGenes <- c(otherNumGenes, tumors[i, "nMutGenes"])
  }
}

print(paste("Mean CL is:", mean(clNumGenes)))
print(paste("Mean other is:", mean(otherNumGenes)))
t <- t.test(x = clNumGenes, y = otherNumGenes)
print(paste("P-value is:", t$p.value))