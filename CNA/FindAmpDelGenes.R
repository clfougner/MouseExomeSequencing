#!/bin/RScript

sampleNames<-c('S123_14_6', 'S131_14_9', 'S132_14_5', 'S153_14_2',
               'S159_14_2', 'S159_14_8', 'S160_14_2', 'S176_14_2',
               'S187_14_1', 'S189_14_2', 'S189_14_4', 'S400_15_2',
               'S400_15_7', 'S401_15_2', 'S412_15_2', 'S416_15_2',
               'S416_15_13', 'S422_15_2')

for(sampleName in sampleNames){
  CNATableFileName<-paste("/open/tmp/Christian/DMBA-induced/Output/EXCAVATOR2/w10k/AnalysisResults_w10k/Results/", sampleName, "/FastCallResults_", sampleName, ".txt", sep="")
  CNATable<-read.table(file=CNATableFileName, sep="\t", header=TRUE)
  
  all<-c()
  for (i in 1:length(CNATable$Chromosome)){
    if (CNATable[i, "ProbCall"] > 0.00){
      all<-c(all, i)
    }
  }
  
  CNATable<-CNATable[all, ]
  
  bedFormatted<-data.frame(chrom=CNATable[,"Chromosome"], start=CNATable[,"Start"], end=CNATable[,"End"]) 
  
  bedFormattedFileName<-paste("/open/tmp/Christian/DMBA-induced/Output/EXCAVATOR2/w10k/AnalysisResults_w10k/Intersect/", sampleName, "_CNA.bed", sep="")
  write.table(x=bedFormatted, file=bedFormattedFileName, quote=FALSE, row.names=FALSE, sep="\t", col.names=FALSE)
  
  bedtoolsIntersectOutput<-paste("/open/tmp/Christian/DMBA-induced/Output/EXCAVATOR2/w10k/AnalysisResults_w10k/Intersect/", sampleName, "_CNA_intersect.bed", sep="")
  
  system(paste("bedtools intersect -a ", bedFormattedFileName, " -b /open/tmp/Christian/ReferenceFiles/mm10genesRefSeqForIntersect.bed -wa -wb > ", bedtoolsIntersectOutput, sep=""))
  print("1") 
  #system("bedtools intersect -a /open/tmp/Christian/DMBA-induced/Output/EXCAVATOR2/w50/AnalysisResults_w50k/Intersect/S123_14_6_CNA_0.95.bed -b /open/tmp/Christian/ReferenceFiles/mm10genesRefSeqForIntersect.bed -wa -wb > /open/tmp/Christian/DMBA-induced/Output/EXCAVATOR2/w50/AnalysisResults_w50k/Intersect/S123_14_6_CNA_intersect.bed")
  
  intersected<-read.table(file=bedtoolsIntersectOutput, sep="\t", header=FALSE)
  
  #print(intersected[950:952,])
  #print(CNATable)
  
  intersected<-data.frame(chrom=intersected$V1, start=intersected$V5, end=intersected$V6, refSeq=intersected$V7, geneName=rep(NA, times=length(intersected$V1)), copyNumber=rep(NA, times=length(intersected$V1)), prob=rep(NA, times=length(intersected$V1)), CNA=rep(NA, times=length(intersected$V1)), segStart=intersected$V2)
  
  #print(intersected[950:952,])
  
  geneNames<-read.table(file="/open/tmp/Christian/ReferenceFiles/Refseq2Gene.txt", sep="\t", header=FALSE, na.strings="", col.names=c("refSeq", "geneSymbol"))
  
  geneNames<-unique(geneNames)
  
  for (i in 1:length(intersected$chrom)){
    line<-grep(pattern=intersected[i,"segStart"], x= CNATable[, "Start"])
    line<-line[1]
    intersected[i, "copyNumber"]<-CNATable[line, "CN"]
    intersected[i, "prob"]<-CNATable[line, "ProbCall"]
    
    if (intersected[i, "copyNumber"] == 1){
      intersected[i, "CNA"]<-"del"
    }
    
    if (intersected[i, "copyNumber"] > 2){
      intersected[i, "CNA"]<-"amp"
    }
    
    lineGeneName<-grep(pattern=intersected[i, "refSeq"], x=geneNames[, "refSeq"])
    if(length(lineGeneName) == 0){
      print(paste(intersected[i, "refSeq"], " not found"))
    }
    
    if(length(lineGeneName) != 0){
      intersected[i, "geneName"]<-as.character(geneNames[lineGeneName[1], "geneSymbol"])
    }
  }
  
  intersected<-intersected[, 1:8]
  
  annotatedOutputFileName<-paste("/open/tmp/Christian/DMBA-induced/Output/EXCAVATOR2/w10k/AnalysisResults_w10k/Intersect/", sampleName, "_CNA_annotated.txt", sep="")
  write.table(x=intersected, file=annotatedOutputFileName, quote=FALSE, row.names=FALSE, sep="\t", col.names=TRUE)
}
