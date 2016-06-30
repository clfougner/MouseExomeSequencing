#!/usr/local/bin/Rscript

args<-commandArgs()
filename<-args[6]
outputExtension<-'.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.txt'
outputPath<-'FilterTests/OnePerLineAD10AF005RFModGrep/UniqueCoordinates/'
master<-args[7]
sampleNumber<-args[8]

file<-read.table(file=filename)
file<-file[!duplicated(file$V2),]

outputFileName<-paste(master, outputPath, sampleNumber, outputExtension, sep='')
write.table(file, file=outputFileName, col.names = F, row.names = F, quote=F, sep="\t")

quit()