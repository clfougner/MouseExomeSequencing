## See https://github.com/clfougner/MouseExomeSequencing/tree/master/Figures for
## explanation of steps carried out in modifying deconstructSigs to work for
## mouse data
library(deconstructSigs)

#########################################################################################
## Read variant lists as extracted from SnpSiftExtract.sh
#########################################################################################
S123_14_6_table<-read.table("/Volumes/open/tmp/Christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RF/UniqueCoordinates/123_14_6.AD10AF005FR.annotated.passfiltered.extracted.dedup.txt", sep='\t')
S131_14_9_table<-read.table("/Volumes/open/tmp/Christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RF/UniqueCoordinates/131_14_9.AD10AF005FR.annotated.passfiltered.extracted.dedup.txt", sep='\t')
S132_14_5_table<-read.table("/Volumes/open/tmp/Christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RF/UniqueCoordinates/132_14_5.AD10AF005FR.annotated.passfiltered.extracted.dedup.txt", sep='\t')
S153_14_2_table<-read.table("/Volumes/open/tmp/Christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RF/UniqueCoordinates/153_14_2.AD10AF005FR.annotated.passfiltered.extracted.dedup.txt", sep='\t')
S159_14_2_table<-read.table("/Volumes/open/tmp/Christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RF/UniqueCoordinates/159_14_2.AD10AF005FR.annotated.passfiltered.extracted.dedup.txt", sep='\t')
S159_14_8_table<-read.table("/Volumes/open/tmp/Christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RF/UniqueCoordinates/159_14_8.AD10AF005FR.annotated.passfiltered.extracted.dedup.txt", sep='\t')
S160_14_2_table<-read.table("/Volumes/open/tmp/Christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RF/UniqueCoordinates/160_14_2.AD10AF005FR.annotated.passfiltered.extracted.dedup.txt", sep='\t')
S176_14_2_table<-read.table("/Volumes/open/tmp/Christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RF/UniqueCoordinates/176_14_2.AD10AF005FR.annotated.passfiltered.extracted.dedup.txt", sep='\t')
S187_14_1_table<-read.table("/Volumes/open/tmp/Christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RF/UniqueCoordinates/187_14_1.AD10AF005FR.annotated.passfiltered.extracted.dedup.txt", sep='\t')
S189_14_2_table<-read.table("/Volumes/open/tmp/Christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RF/UniqueCoordinates/189_14_2.AD10AF005FR.annotated.passfiltered.extracted.dedup.txt", sep='\t')
S189_14_4_table<-read.table("/Volumes/open/tmp/Christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RF/UniqueCoordinates/189_14_4.AD10AF005FR.annotated.passfiltered.extracted.dedup.txt", sep='\t')
S400_15_2_table<-read.table("/Volumes/open/tmp/Christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RF/UniqueCoordinates/400_15_2.AD10AF005FR.annotated.passfiltered.extracted.dedup.txt", sep='\t')
S400_15_7_table<-read.table("/Volumes/open/tmp/Christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RF/UniqueCoordinates/400_15_7.AD10AF005FR.annotated.passfiltered.extracted.dedup.txt", sep='\t')
S401_15_2_table<-read.table("/Volumes/open/tmp/Christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RF/UniqueCoordinates/401_15_2.AD10AF005FR.annotated.passfiltered.extracted.dedup.txt", sep='\t')
S412_15_2_table<-read.table("/Volumes/open/tmp/Christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RF/UniqueCoordinates/412_15_2.AD10AF005FR.annotated.passfiltered.extracted.dedup.txt", sep='\t')
S416_15_13_table<-read.table("/Volumes/open/tmp/Christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RF/UniqueCoordinates/415_15_13.AD10AF005FR.annotated.passfiltered.extracted.dedup.txt", sep='\t')
S416_15_2_table<-read.table("/Volumes/open/tmp/Christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RF/UniqueCoordinates/416_15_2.AD10AF005FR.annotated.passfiltered.extracted.dedup.txt", sep='\t')
S422_15_2_table<-read.table("/Volumes/open/tmp/Christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RF/UniqueCoordinates/422_15_2.AD10AF005FR.annotated.passfiltered.extracted.dedup.txt", sep='\t')

#########################################################################################
## Create data frame of variant lists in the long format with columns for sample name
## chromosome number, variant position/coordinate, reference and alternate bases.
#########################################################################################
df1<-data.frame(sample=c(rep('S123_14_6', times=(length(S123_14_6_table$V3)))), chr=S123_14_6_table$V1, pos=S123_14_6_table$V2, ref=S123_14_6_table$V3, alt=S123_14_6_table$V4)
df2<-data.frame(sample=c(rep('S131_14_9', times=(length(S131_14_9_table$V3)))), chr=S131_14_9_table$V1, pos=S131_14_9_table$V2, ref=S131_14_9_table$V3, alt=S131_14_9_table$V4)
df3<-data.frame(sample=c(rep('S132_14_5', times=(length(S132_14_5_table$V3)))), chr=S132_14_5_table$V1, pos=S132_14_5_table$V2, ref=S132_14_5_table$V3, alt=S132_14_5_table$V4)
df4<-data.frame(sample=c(rep('S153_14_2', times=(length(S153_14_2_table$V3)))), chr=S153_14_2_table$V1, pos=S153_14_2_table$V2, ref=S153_14_2_table$V3, alt=S153_14_2_table$V4)
df5<-data.frame(sample=c(rep('S159_14_2', times=(length(S159_14_2_table$V3)))), chr=S159_14_2_table$V1, pos=S159_14_2_table$V2, ref=S159_14_2_table$V3, alt=S159_14_2_table$V4)
df6<-data.frame(sample=c(rep('S159_14_8', times=(length(S159_14_8_table$V3)))), chr=S159_14_8_table$V1, pos=S159_14_8_table$V2, ref=S159_14_8_table$V3, alt=S159_14_8_table$V4)
df7<-data.frame(sample=c(rep('S160_14_2', times=(length(S160_14_2_table$V3)))), chr=S160_14_2_table$V1, pos=S160_14_2_table$V2, ref=S160_14_2_table$V3, alt=S160_14_2_table$V4)
df8<-data.frame(sample=c(rep('S176_14_2', times=(length(S176_14_2_table$V3)))), chr=S176_14_2_table$V1, pos=S176_14_2_table$V2, ref=S176_14_2_table$V3, alt=S176_14_2_table$V4)
df9<-data.frame(sample=c(rep('S187_14_1', times=(length(S187_14_1_table$V3)))), chr=S187_14_1_table$V1, pos=S187_14_1_table$V2, ref=S187_14_1_table$V3, alt=S187_14_1_table$V4)
df10<-data.frame(sample=c(rep('S189_14_2', times=(length(S189_14_2_table$V3)))), chr=S189_14_2_table$V1, pos=S189_14_2_table$V2, ref=S189_14_2_table$V3, alt=S189_14_2_table$V4)
df11<-data.frame(sample=c(rep('S189_14_4', times=(length(S189_14_4_table$V3)))), chr=S189_14_4_table$V1, pos=S189_14_4_table$V2, ref=S189_14_4_table$V3, alt=S189_14_4_table$V4)
df12<-data.frame(sample=c(rep('S400_15_2', times=(length(S400_15_2_table$V3)))), chr=S400_15_2_table$V1, pos=S400_15_2_table$V2, ref=S400_15_2_table$V3, alt=S400_15_2_table$V4)
df13<-data.frame(sample=c(rep('S400_15_7', times=(length(S400_15_7_table$V3)))), chr=S400_15_7_table$V1, pos=S400_15_7_table$V2, ref=S400_15_7_table$V3, alt=S400_15_7_table$V4)
df14<-data.frame(sample=c(rep('S401_15_2', times=(length(S401_15_2_table$V3)))), chr=S401_15_2_table$V1, pos=S401_15_2_table$V2, ref=S401_15_2_table$V3, alt=S401_15_2_table$V4)
df15<-data.frame(sample=c(rep('S412_15_2', times=(length(S412_15_2_table$V3)))), chr=S412_15_2_table$V1, pos=S412_15_2_table$V2, ref=S412_15_2_table$V3, alt=S412_15_2_table$V4)
df16<-data.frame(sample=c(rep('S416_15_13', times=(length(S416_15_13_table$V3)))), chr=S416_15_13_table$V1, pos=S416_15_13_table$V2, ref=S416_15_13_table$V3, alt=S416_15_13_table$V4)
df17<-data.frame(sample=c(rep('S416_15_2', times=(length(S416_15_2_table$V3)))), chr=S416_15_2_table$V1, pos=S416_15_2_table$V2, ref=S416_15_2_table$V3, alt=S416_15_2_table$V4)
df18<-data.frame(sample=c(rep('S422_15_2', times=(length(S422_15_2_table$V3)))), chr=S422_15_2_table$V1, pos=S422_15_2_table$V2, ref=S422_15_2_table$V3, alt=S422_15_2_table$V4)

#########################################################################################
## Place all data in one data frame
#########################################################################################
alldfs<-rbind(df1, df2, df3, df4, df5, df6, df7, df8, df9, df10,
             df11, df12, df13, df14, df15, df16, df17, df18)
alldfs
#########################################################################################
## Create input to whichSignatures
#########################################################################################
sigs.input <- mut.to.sigs.input(mut.ref = alldfs, 
                                sample.id = "sample", 
                                chr = "chr", 
                                pos = "pos", 
                                ref = "ref", 
                                alt = "alt")

#########################################################################################
## Create list of sample names (must correspond to the sample= column in alldfs!)
#########################################################################################
sampleNames<-c('S123_14_6', 'S131_14_9', 'S132_14_5', 'S153_14_2',
               'S159_14_2', 'S159_14_8', 'S160_14_2', 'S176_14_2',
               'S187_14_1', 'S189_14_2', 'S189_14_4', 'S400_15_2',
               'S400_15_7', 'S401_15_2', 'S412_15_2', 'S416_15_2',
               'S416_15_13', 'S422_15_2')

#########################################################################################
## Create charts for all samples
#########################################################################################
df<-data.frame(dim=1:30)
for (sn in sampleNames){
wchSig = whichSignatures(tumor.ref = sigs.input, 
                         signatures.ref = signatures.cosmic, 
                         sample.id = sn, 
                         contexts.needed = TRUE,
                         tri.counts.method = 'default')

outputFileName<-paste(sn, '.deconstructSigs.pdf', sep='')
pdf(outputFileName, width = 10, height = 10)
#chart<-plotSignatures(wchSig)
#dev.off()
df[,sn]<-unlist(wchSig$weights)
}

df2<-df[c(4,22,25), 2:19]
row.names(df2)<-c("Sig4","Sig22","Sig25")
write.table(df2, file="MutationalSignatures.txt", quote = FALSE, sep="\t")
