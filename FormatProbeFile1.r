setwd('/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/S0276129/')

probeFile<-read.table(file='S0276129_Probes.txt')

newProbeFile<-data.frame(probeFile$V6, probeFile$V1)

write.table(newProbeFile, file='OnlyCoordinatesAndID.txt', sep='\t', quote=FALSE, row.names=FALSE, col.names=FALSE)
