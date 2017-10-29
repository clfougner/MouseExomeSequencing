
COSMICGenes<-read.table(file='/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/CosmicHomologs.txt')
COSMICGenes<-as.character(COSMICGenes$V1)

CNAList<-read.table(file='/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/AnalysisResults_w50k/CollatedAmpDelList-4.txt', sep="\t", header=TRUE)

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

write.table(COSMICCNAs, file="/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/AnalysisResults_w50k/CollatedAmpDelListCOSMICfiltered.txt", quote = FALSE, sep='\t', row.names=TRUE)