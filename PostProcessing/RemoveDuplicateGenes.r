#!/usr/local/bin/Rscript

args<-commandArgs()
filename<-args[6]
outputExtension<-'.modlowgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.dedupgenes.txt'
outputPath<-'FilterTests/OnePerLineAD10AF005RFModLowGrep/UniqueGenes/'
master<-args[7]
sampleNumber<-args[8]

file<-read.table(file=filename, sep='\t')
file<-file[!duplicated(file$V5),]

outputFileName<-paste(master, outputPath, sampleNumber, outputExtension, sep='')
write.table(file, file=outputFileName, col.names = F, row.names = F, quote=F, sep="\t")

quit()