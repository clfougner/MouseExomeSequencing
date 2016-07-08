#!/usr/local/bin/Rscript

args<-commandArgs()
filename<-args[6]
outputExtension<-'.modlowgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.txt'
outputPath<-'FilterTests/OnePerLineAD10AF005RFModLowGrep/UniqueCoordinates/'
master<-args[7]
sampleNumber<-args[8]

file<-read.table(file=filename, sep='\t')
file$V12<-paste(file$V1, file$V2, sep=':')
file<-file[!duplicated(file$V12),]

outputFileName<-paste(master, outputPath, sampleNumber, outputExtension, sep='')
write.table(file, file=outputFileName, col.names = F, row.names = F, quote=F, sep="\t")

quit()