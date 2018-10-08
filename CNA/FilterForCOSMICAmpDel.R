
COSMICGenes<-read.table(file='/Users/christianfougner/Documents/Forskning/DMBA-prosjekt/Sequencing/ReferenceFiles/CosmicHomologs.txt')
COSMICGenes<-as.character(COSMICGenes$V1)

CNAList<-read.table(file='/Users/christianfougner/Documents/Forskning/DMBA-prosjekt/Sequencing/Output/AnalysisResults_w20k/Analysis/CollatedAmpDelList_w20k_call_notfiltered.txt', sep="\t", header=TRUE)

CNAList <- cbind(Gene=row.names(CNAList), CNAList)

allPositions<-c()

for (i in COSMICGenes){
  geneName<-paste("^", i, "$", sep="")
  position<-grep(pattern=geneName, x=CNAList$Gene)
  if (length(position)>0){
    allPositions<-c(allPositions, position)
  }
}

COSMICCNAs<-CNAList[allPositions, ]

COSMICCNAs<-COSMICCNAs[complete.cases(COSMICCNAs$Sum),]

COSMICCNAs<-COSMICCNAs[order(-COSMICCNAs$Sum),]

COSMICCNAs <- COSMICCNAs[!duplicated(COSMICCNAs$Gene),]

COSMICCNAs <- data.frame(COSMICCNAs[,2:20], row.names = COSMICCNAs[,1])

write.table(COSMICCNAs, file="/Users/christianfougner/Documents/Forskning/DMBA-prosjekt/Sequencing/Output/AnalysisResults_w20k/Analysis/CollatedAmpDelList_w20k_call_notfiltered_COSMIC.txt", quote = FALSE, sep='\t', row.names=TRUE)