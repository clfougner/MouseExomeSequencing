library(VennDiagram)

sampleNames<-c('S123_14_6', 'S131_14_9', 'S132_14_5', 'S153_14_2',
               'S159_14_2', 'S159_14_8', 'S160_14_2', 'S176_14_2',
               'S187_14_1', 'S189_14_2', 'S189_14_4', 'S400_15_2',
               'S400_15_7', 'S401_15_2', 'S412_15_2', 'S416_15_2',
               'S416_15_13', 'S422_15_2')

df<-data.frame(w10k=NA, w20k=NA, w50k = NA, w10kw20k=NA, w10kw50k=NA, w20kw50k=NA, w10kw20kw50k=NA)

for(sampleName in sampleNames){
  grid.newpage()
  w10<-paste("/Volumes/open/tmp/Christian/DMBA-induced/Output/EXCAVATOR2/w10k/AnalysisResults_w10k/Intersect/", sampleName, "_CNA_0.95_annotated.txt", sep="")
  w10Table<-read.table(file=w10, sep="\t", header=TRUE)
  w10Genes<-unique(as.vector(w10Table$geneName))
  
  w20<-paste("/Volumes/open/tmp/Christian/DMBA-induced/Output/EXCAVATOR2/w20k/AnalysisResults_w20k/Intersect/", sampleName, "_CNA_0.95_annotated.txt", sep="")
  w20Table<-read.table(file=w20, sep="\t", header=TRUE)
  w20Genes<-unique(as.vector(w20Table$geneName))
  
  w50<-paste("/Volumes/open/tmp/Christian/DMBA-induced/Output/EXCAVATOR2/w50k/AnalysisResults_w50k/Intersect/", sampleName, "_CNA_0.95_annotated.txt", sep="")
  w50Table<-read.table(file=w50, sep="\t", header=TRUE)
  w50Genes<-unique(as.vector(w50Table$geneName))
  
  w10<-length(w10Genes)
  w20<-length(w20Genes)
  w50<-length(w50Genes)
  
  w10w20<-length(Reduce(intersect, list(w10Genes,w20Genes)))
  w10w50<-length(Reduce(intersect, list(w10Genes,w50Genes)))
  w20w50<-length(Reduce(intersect, list(w20Genes,w50Genes)))
  
  w10w20w50<-length(Reduce(intersect, list(w10Genes,w20Genes,w50Genes)))
  
  df2<-data.frame(w10k=w10, w20k=w20, w50k = w50, w10kw20k=w10w20, w10kw50k=w10w50, w20kw50k=w20w50, w10kw20kw50k=w10w20w50)
  
  df<-rbind(df, df2)
  
  draw.triple.venn(area1=w10, area2=w20, area3=w50, n12 = w10w20, n13=w10w50, n23=w20w50, n123=w10w20w50, category = c("w10k", "w20k", "w50k"))
  
}

df<-df[2:length(df$w10k),]
row.names(df)<-sampleNames
