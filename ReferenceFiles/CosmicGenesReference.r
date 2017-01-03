setwd("/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/")

list<-read.csv("cancer_gene_census.csv")
newList<-list$Gene.Symbol

write.table(newList, file='cosmicGenes.txt', sep='\t', quote=F, row.names=F, col.names=F)

#http://www.genenames.org/cgi-bin/hcop

homologs<-read.table("CosmicHomologsDets.txt", sep='\t')
write.table(homologs$V4, file='CosmicHomologs.txt', sep='\t', quote=F, row.names=F, col.names=F)
