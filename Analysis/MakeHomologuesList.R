#This is the worst code I have ever written

setwd("~/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/OnePerLineAD10AF005RFModGrep")
allFiles<-list.files("~/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/OnePerLineAD10AF005RFModGrep")

fileNames<-c("S123_14_6", "S131_14_9", "S132_14_5", "S153_14_2", "S159_14_2", "S159_14_8", "S160_14_2", "S176_14_2", "S187_14_1", "S189_14_2", "S189_14_4", "S400_15_2", "S400_15_7", "S401_15_2", "S412_15_2", "S416_15_13", "S416_15_2", "S422_15_2")

## Read variant lists as extracted from SnpSiftExtract.sh
S123_14_6_table<-read.table(allFiles[1], sep='\t')
S131_14_9_table<-read.table(allFiles[2], sep='\t')
S132_14_5_table<-read.table(allFiles[3], sep='\t')
S153_14_2_table<-read.table(allFiles[4], sep='\t')
S159_14_2_table<-read.table(allFiles[5], sep='\t')
S159_14_8_table<-read.table(allFiles[6], sep='\t')
S160_14_2_table<-read.table(allFiles[7], sep='\t')
S176_14_2_table<-read.table(allFiles[8], sep='\t')
S187_14_1_table<-read.table(allFiles[9], sep='\t')
S189_14_2_table<-read.table(allFiles[10], sep='\t')
S189_14_4_table<-read.table(allFiles[11], sep='\t')
S400_15_2_table<-read.table(allFiles[12], sep='\t')
S400_15_7_table<-read.table(allFiles[13], sep='\t')
S401_15_2_table<-read.table(allFiles[14], sep='\t')
S412_15_2_table<-read.table(allFiles[15], sep='\t')
S416_15_13_table<-read.table(allFiles[16], sep='\t')
S416_15_2_table<-read.table(allFiles[17], sep='\t')
S422_15_2_table<-read.table(allFiles[18], sep='\t')

dflist<-c(S123_14_6_table, S131_14_9_table, S132_14_5_table, S153_14_2_table, S159_14_2_table, S159_14_8_table, S160_14_2_table, S176_14_2_table, S187_14_1_table, S189_14_2_table, S189_14_4_table, S400_15_2_table, S400_15_7_table, S401_15_2_table, S412_15_2_table, S416_15_13_table, S416_15_2_table, S422_15_2_table)



  S123_14_6_table<-S123_14_6_table[- grep("LOW", S123_14_6_table$V10), ]
  S131_14_9_table<-S131_14_9_table[- grep("LOW", S131_14_9_table$V10), ]
  S132_14_5_table<-S132_14_5_table[- grep("LOW", S132_14_5_table$V10), ]
  S153_14_2_table<-S153_14_2_table[- grep("LOW", S153_14_2_table$V10), ]
  S159_14_2_table<-S159_14_2_table[- grep("LOW", S159_14_2_table$V10), ]
  S159_14_8_table<-S159_14_8_table[- grep("LOW", S159_14_8_table$V10), ]
  S160_14_2_table<-S160_14_2_table[- grep("LOW", S160_14_2_table$V10), ]
  S176_14_2_table<-S176_14_2_table[- grep("LOW", S176_14_2_table$V10), ]
  S187_14_1_table<-S187_14_1_table[- grep("LOW", S187_14_1_table$V10), ]
  S189_14_2_table<-S189_14_2_table[- grep("LOW", S189_14_2_table$V10), ]
  S189_14_4_table<-S189_14_4_table[- grep("LOW", S189_14_4_table$V10), ]
  S400_15_2_table<-S400_15_2_table[- grep("LOW", S400_15_2_table$V10), ]
  S400_15_7_table<-S400_15_7_table[- grep("LOW", S400_15_7_table$V10), ]
  S401_15_2_table<-S401_15_2_table[- grep("LOW", S401_15_2_table$V10), ]
  S412_15_2_table<-S412_15_2_table[- grep("LOW", S412_15_2_table$V10), ]
  S416_15_13_table<-S416_15_13_table[- grep("LOW", S416_15_13_table$V10), ]
  S416_15_2_table<-S416_15_2_table[- grep("LOW", S416_15_2_table$V10), ]
  S422_15_2_table<-S422_15_2_table[- grep("LOW", S422_15_2_table$V10), ]
  




## Create data frame of variant lists
df1<-data.frame(sample=c(rep(fileNames[1], times=(length(S123_14_6_table$V3)))), gene=S123_14_6_table$V5, location=S123_14_6_table$V14, ref=S123_14_6_table$V3, alt=S123_14_6_table$V4, AA_change=S123_14_6_table$V11, nucleotide_change=S123_14_6_table$V13)
df2<-data.frame(sample=c(rep(fileNames[2], times=(length(S131_14_9_table$V3)))), gene=S131_14_9_table$V5, location=S131_14_9_table$V14, ref=S131_14_9_table$V3, alt=S131_14_9_table$V4, AA_change=S131_14_9_table$V11, nucleotide_change=S131_14_9_table$V13)
df3<-data.frame(sample=c(rep(fileNames[3], times=(length(S132_14_5_table$V3)))), gene=S132_14_5_table$V5, location=S132_14_5_table$V14, ref=S132_14_5_table$V3, alt=S132_14_5_table$V4, AA_change=S132_14_5_table$V11, nucleotide_change=S132_14_5_table$V13)
df4<-data.frame(sample=c(rep(fileNames[4], times=(length(S153_14_2_table$V3)))), gene=S153_14_2_table$V5, location=S153_14_2_table$V14, ref=S153_14_2_table$V3, alt=S153_14_2_table$V4, AA_change=S153_14_2_table$V11, nucleotide_change=S153_14_2_table$V13)
df5<-data.frame(sample=c(rep(fileNames[5], times=(length(S159_14_2_table$V3)))), gene=S159_14_2_table$V5, location=S159_14_2_table$V14, ref=S159_14_2_table$V3, alt=S159_14_2_table$V4, AA_change=S159_14_2_table$V11, nucleotide_change=S159_14_2_table$V13)
df6<-data.frame(sample=c(rep(fileNames[6], times=(length(S159_14_8_table$V3)))), gene=S159_14_8_table$V5, location=S159_14_8_table$V14, ref=S159_14_8_table$V3, alt=S159_14_8_table$V4, AA_change=S159_14_8_table$V11, nucleotide_change=S159_14_8_table$V13)
df7<-data.frame(sample=c(rep(fileNames[7], times=(length(S160_14_2_table$V3)))), gene=S160_14_2_table$V5, location=S160_14_2_table$V14, ref=S160_14_2_table$V3, alt=S160_14_2_table$V4, AA_change=S160_14_2_table$V11, nucleotide_change=S160_14_2_table$V13)
df8<-data.frame(sample=c(rep(fileNames[8], times=(length(S176_14_2_table$V3)))), gene=S176_14_2_table$V5, location=S176_14_2_table$V14, ref=S176_14_2_table$V3, alt=S176_14_2_table$V4, AA_change=S176_14_2_table$V11, nucleotide_change=S176_14_2_table$V13)
df9<-data.frame(sample=c(rep(fileNames[9], times=(length(S187_14_1_table$V3)))), gene=S187_14_1_table$V5, location=S187_14_1_table$V14, ref=S187_14_1_table$V3, alt=S187_14_1_table$V4, AA_change=S187_14_1_table$V11, nucleotide_change=S187_14_1_table$V13)
df10<-data.frame(sample=c(rep(fileNames[10], times=(length(S189_14_2_table$V3)))), gene=S189_14_2_table$V5, location=S189_14_2_table$V14, ref=S189_14_2_table$V3, alt=S189_14_2_table$V4, AA_change=S189_14_2_table$V11, nucleotide_change=S189_14_2_table$V13)
df11<-data.frame(sample=c(rep(fileNames[11], times=(length(S189_14_4_table$V3)))), gene=S189_14_4_table$V5, location=S189_14_4_table$V14, ref=S189_14_4_table$V3, alt=S189_14_4_table$V4, AA_change=S189_14_4_table$V11, nucleotide_change=S189_14_4_table$V13)
df12<-data.frame(sample=c(rep(fileNames[12], times=(length(S400_15_2_table$V3)))), gene=S400_15_2_table$V5, location=S400_15_2_table$V14, ref=S400_15_2_table$V3, alt=S400_15_2_table$V4, AA_change=S400_15_2_table$V11, nucleotide_change=S400_15_2_table$V13)
df13<-data.frame(sample=c(rep(fileNames[13], times=(length(S400_15_7_table$V3)))), gene=S400_15_7_table$V5, location=S400_15_7_table$V14, ref=S400_15_7_table$V3, alt=S400_15_7_table$V4, AA_change=S400_15_7_table$V11, nucleotide_change=S400_15_7_table$V13)
df14<-data.frame(sample=c(rep(fileNames[14], times=(length(S401_15_2_table$V3)))), gene=S401_15_2_table$V5, location=S401_15_2_table$V14, ref=S401_15_2_table$V3, alt=S401_15_2_table$V4, AA_change=S401_15_2_table$V11, nucleotide_change=S401_15_2_table$V13)
df15<-data.frame(sample=c(rep(fileNames[15], times=(length(S412_15_2_table$V3)))), gene=S412_15_2_table$V5, location=S412_15_2_table$V14, ref=S412_15_2_table$V3, alt=S412_15_2_table$V4, AA_change=S412_15_2_table$V11, nucleotide_change=S412_15_2_table$V13)
df16<-data.frame(sample=c(rep(fileNames[16], times=(length(S416_15_13_table$V3)))), gene=S416_15_13_table$V5, location=S416_15_13_table$V14, ref=S416_15_13_table$V3, alt=S416_15_13_table$V4, AA_change=S416_15_13_table$V11, nucleotide_change=S416_15_13_table$V13)
df17<-data.frame(sample=c(rep(fileNames[17], times=(length(S416_15_2_table$V3)))), gene=S416_15_2_table$V5, location=S416_15_2_table$V14, ref=S416_15_2_table$V3, alt=S416_15_2_table$V4, AA_change=S416_15_2_table$V11, nucleotide_change=S416_15_2_table$V13)
df18<-data.frame(sample=c(rep(fileNames[18], times=(length(S422_15_2_table$V3)))), gene=S422_15_2_table$V5, location=S422_15_2_table$V14, ref=S422_15_2_table$V3, alt=S422_15_2_table$V4, AA_change=S422_15_2_table$V11, nucleotide_change=S422_15_2_table$V13)


#########################################################################################
## Place all data in one data frame
#########################################################################################
alldfs<-rbind(df1, df2, df3, df4, df5, df6, df7, df8, df9, df10,
              df11, df12, df13, df14, df15, df16, df17, df18)

COSMIC<-read.table("~/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/CosmicHomologs.txt")
newdf<-data.frame(sample=NULL, gene=NULL, location=NULL, ref=NULL, alt=NULL, AA_change=NULL)
for (i in 1:length(COSMIC$V1)){
  line<-grep(pattern=paste("^",COSMIC[i,1],"$", sep=""), x=alldfs$gene)
  newdf<-rbind(newdf, alldfs[line,])
}

write.table(newdf, file="SX.COSMICHomologsV22.txt", quote=FALSE, sep="\t", row.names=FALSE)
