##########################################################################################

##########################################################################################
vogelstein<-read.table(file='ReferenceFiles/CosmicHomologs.txt')

#########################################################################################
## File from CommonGeneList.r
#########################################################################################
orderedGenes<-read.table(file='OrderedListSpecificModLow.txt')
df<-data.frame(orderedGenes)


#########################################################################################
## Filter genes in orderedGenes for those found in vogelstein
#########################################################################################
genes<-c(as.character(vogelstein$V1))
selected<-df[genes,]
selected<-selected[complete.cases(selected$Sum),]
selected<-selected[order(-selected[,'Sum'],selected[,1]), ]

#########################################################################################
## Print table
#########################################################################################
write.table(selected, file='OrderedListSpecificCOSMICFiltered.txt', quote = FALSE, sep='\t')

newDF<-data.frame(matrix(data=0, nrow=180, ncol=18))

for (i in 1:18){
  for (n in 1:180){
    
    if (is.na(selected[n,i])){
      next
    }
    
    if (selected[n, i]){
      newDF[n,i]<-1
    } 
  }
}
alltot<-c()
for (i in 1:18){
  tot<-sum(newDF[,i])
  alltot<-c(alltot,tot)
  print(tot)
}

range(alltot)
mean(alltot)
median(alltot)
  