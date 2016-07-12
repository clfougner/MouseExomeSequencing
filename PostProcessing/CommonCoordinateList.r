#!/usr/local/bin/Rscript

#########################################################################
## Create list of all genes (must have passed through ModGrepPipeline.sh
## with RemoveDuplicateVariants.r)
#########################################################################
S123_14_6_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RFModGrep/UniqueCoordinates/123_14_6.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.txt")
S131_14_9_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RFModGrep/UniqueCoordinates/131_14_9.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.txt")
S132_14_5_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RFModGrep/UniqueCoordinates/132_14_5.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.txt")
S153_14_2_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RFModGrep/UniqueCoordinates/153_14_2.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.txt")
S159_14_2_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RFModGrep/UniqueCoordinates/159_14_2.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.txt")
S159_14_8_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RFModGrep/UniqueCoordinates/159_14_8.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.txt")
S160_14_2_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RFModGrep/UniqueCoordinates/160_14_2.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.txt")
S176_14_2_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RFModGrep/UniqueCoordinates/176_14_2.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.txt")
S187_14_1_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RFModGrep/UniqueCoordinates/187_14_1.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.txt")
S189_14_2_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RFModGrep/UniqueCoordinates/189_14_2.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.txt")
S189_14_4_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RFModGrep/UniqueCoordinates/189_14_4.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.txt")
S400_15_2_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RFModGrep/UniqueCoordinates/400_15_2.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.txt")
S400_15_7_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RFModGrep/UniqueCoordinates/400_15_7.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.txt")
S401_15_2_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RFModGrep/UniqueCoordinates/401_15_2.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.txt")
S412_15_2_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RFModGrep/UniqueCoordinates/412_15_2.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.txt")
S416_15_13_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RFModGrep/UniqueCoordinates/415_15_13.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.txt")
S416_15_2_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RFModGrep/UniqueCoordinates/416_15_2.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.txt")
S422_15_2_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RFModGrep/UniqueCoordinates/422_15_2.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.txt")

#########################################################################
## Create list of all sample names
#########################################################################
sampleNames<-c('S123_14_6', 'S131_14_9', 'S132_14_5', 'S153_14_2',
               'S159_14_2', 'S159_14_8', 'S160_14_2', 'S176_14_2',
               'S187_14_1', 'S189_14_2', 'S189_14_4', 'S400_15_2',
               'S400_15_7', 'S401_15_2', 'S412_15_2', 'S416_15_2',
               'S416_15_13', 'S422_15_2')

#########################################################################
## Create list of all positions with variants for the given sample
## (format: chrN:nnnnnnnnn)
#########################################################################
S123_14_6_list<-c(as.character(S123_14_6_table$V12))
S131_14_9_list<-c(as.character(S131_14_9_table$V12))
S132_14_5_list<-c(as.character(S132_14_5_table$V12))
S153_14_2_list<-c(as.character(S153_14_2_table$V12))
S159_14_2_list<-c(as.character(S159_14_2_table$V12))
S159_14_8_list<-c(as.character(S159_14_8_table$V12))
S160_14_2_list<-c(as.character(S160_14_2_table$V12))
S176_14_2_list<-c(as.character(S176_14_2_table$V12))
S187_14_1_list<-c(as.character(S187_14_1_table$V12))
S189_14_2_list<-c(as.character(S189_14_2_table$V12))
S189_14_4_list<-c(as.character(S189_14_4_table$V12))
S400_15_2_list<-c(as.character(S400_15_2_table$V12))
S400_15_7_list<-c(as.character(S400_15_7_table$V12))
S401_15_2_list<-c(as.character(S401_15_2_table$V12))
S412_15_2_list<-c(as.character(S412_15_2_table$V12))
S416_15_13_list<-c(as.character(S416_15_13_table$V12))
S416_15_2_list<-c(as.character(S416_15_2_table$V12))
S422_15_2_list<-c(as.character(S422_15_2_table$V12))

#########################################################################
## Concatenate all lists into one
#########################################################################
geneList<-c(S123_14_6_list, S131_14_9_list, S132_14_5_list, S153_14_2_list,
            S159_14_2_list, S159_14_8_list, S160_14_2_list, S176_14_2_list,
            S187_14_1_list, S189_14_2_list, S189_14_4_list, S400_15_2_list,
            S400_15_7_list, S401_15_2_list, S412_15_2_list, S416_15_2_list,
            S416_15_13_list, S422_15_2_list)

###################################################################
## Remove all duplicated genes from list
###################################################################
geneList<-geneList[!duplicated(geneList)]

###################################################################
## Create empty data frame of size corresponding to gene list 
## (Important: object names must be identical to sample name in the
## sampleNames object)
###################################################################
numGenes<-length(geneList)
S123_14_6<-rep(0, times=numGenes)
S131_14_9<-rep(0, times=numGenes)
S132_14_5<-rep(0, times=numGenes)
S153_14_2<-rep(0, times=numGenes)
S159_14_2<-rep(0, times=numGenes)
S159_14_8<-rep(0, times=numGenes)
S160_14_2<-rep(0, times=numGenes)
S176_14_2<-rep(0, times=numGenes)
S187_14_1<-rep(0, times=numGenes)
S189_14_2<-rep(0, times=numGenes)
S189_14_4<-rep(0, times=numGenes)
S400_15_2<-rep(0, times=numGenes)
S400_15_7<-rep(0, times=numGenes)
S401_15_2<-rep(0, times=numGenes)
S412_15_2<-rep(0, times=numGenes)
S416_15_2<-rep(0, times=numGenes)
S416_15_13<-rep(0, times=numGenes)
S422_15_2<-rep(0, times=numGenes)
Sum<-rep(0, times=numGenes)

df<-data.frame(S123_14_6, S131_14_9,S132_14_5, S153_14_2,
               S159_14_2, S159_14_8, S160_14_2, S176_14_2,
               S187_14_1, S189_14_2, S189_14_4, S400_15_2,
               S400_15_7, S401_15_2, S412_15_2, S416_15_2,
               S416_15_13, S422_15_2, 
               Sum, row.names=geneList)

###################################################################
## Assign variants to sample object (Important: object names must
## be identical to sample name in the sampleNames object)
###################################################################
S123_14_6<-S123_14_6_list
S131_14_9<-S131_14_9_list
S132_14_5<-S132_14_5_list
S153_14_2<-S153_14_2_list
S159_14_2<-S159_14_2_list
S159_14_8<-S159_14_8_list
S160_14_2<-S160_14_2_list
S176_14_2<-S176_14_2_list
S187_14_1<-S187_14_1_list
S189_14_2<-S189_14_2_list
S189_14_4<-S189_14_4_list
S400_15_2<-S400_15_2_list
S400_15_7<-S400_15_7_list
S401_15_2<-S401_15_2_list
S412_15_2<-S412_15_2_list
S416_15_2<-S416_15_2_list
S416_15_13<-S416_15_13_list
S422_15_2<-S422_15_2_list

###################################################################
## Set given data position value to 1 if variant is found in sample
###################################################################

for (x in sampleNames)
{
  for (y in geneList)
  {
    if (y %in% eval(parse(text=x)))
    {
      df[y,x]<-1
    }
  }
}

###################################################################
## Calculate sum of samples with variant
###################################################################
sum<-rowSums(df)
for (gene in geneList)
{
  df[gene,'Sum']<-sum[gene]
}


###################################################################
## Order gene list by number of samples with variant
###################################################################
ordered<-df[order(-df[,'Sum'],df[,1]), ]

###################################################################
## Print table
###################################################################
write.table(ordered, file='/Volumes/christian/DMBA-induced/Output/Analysis/OrderedListCoordinates.txt', quote = FALSE, sep='\t')

