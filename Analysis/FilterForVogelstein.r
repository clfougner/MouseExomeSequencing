##########################################################################################
## List of genes to filter for (list from 'Cancer Genome Landscapes', B Vogelstein et al.)
## is used here
##########################################################################################
vogelstein<-read.table(file='/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/161005_genesforfigure.txt')

#########################################################################################
## File from CommonGeneList.r
#########################################################################################
orderedGenes<-read.table(file='/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/FinalOut/mm10OrderedListSpecificModLow.txt')
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
write.table(selected, file='/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/FinalOut/VariantsForRaster.txt', quote = FALSE, sep='\t')
