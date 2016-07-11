vogelstein<-read.table(file='/Volumes/christian/ReferenceFiles/VogelsteinGeneListHomologsAsList.txt')
orderedGenes<-read.table(file='/Volumes/christian/DMBA-induced/Output/OrderedListByEffect.txt')

genes<-c(as.character(vogelstein$V1))
df<-data.frame(orderedGenes)
selected<-df[genes,]
selected<-selected[complete.cases(selected$Sum),]
selected<-selected[order(-selected[,'Sum'],selected[,1]), ]

write.table(selected, file='/Volumes/christian/DMBA-induced/Output/OrderedListVogelFiltered.txt', quote = FALSE, sep='\t')
