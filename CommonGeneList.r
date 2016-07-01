
###################################################################
## Create list of all genes
###################################################################
S123_14_6_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RFModGrep/UniqueGenes/123_14_6.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.dedupgenes.txt", stringsAsFactors = FALSE)
S131_14_9_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RFModGrep/UniqueGenes/131_14_9.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.dedupgenes.txt", stringsAsFactors = FALSE)
S132_14_5_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RFModGrep/UniqueGenes/132_14_5.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.dedupgenes.txt", stringsAsFactors = FALSE)
S153_14_2_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RFModGrep/UniqueGenes/153_14_2.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.dedupgenes.txt", stringsAsFactors = FALSE)
S159_14_2_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RFModGrep/UniqueGenes/159_14_2.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.dedupgenes.txt", stringsAsFactors = FALSE)
S159_14_8_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RFModGrep/UniqueGenes/159_14_8.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.dedupgenes.txt", stringsAsFactors = FALSE)
S160_14_2_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RFModGrep/UniqueGenes/160_14_2.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.dedupgenes.txt", stringsAsFactors = FALSE)
S176_14_2_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RFModGrep/UniqueGenes/176_14_2.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.dedupgenes.txt", stringsAsFactors = FALSE)
S187_14_1_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RFModGrep/UniqueGenes/187_14_1.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.dedupgenes.txt", stringsAsFactors = FALSE)
S189_14_2_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RFModGrep/UniqueGenes/189_14_2.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.dedupgenes.txt", stringsAsFactors = FALSE)
S189_14_4_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RFModGrep/UniqueGenes/189_14_4.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.dedupgenes.txt", stringsAsFactors = FALSE)
S400_15_2_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RFModGrep/UniqueGenes/400_15_2.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.dedupgenes.txt", stringsAsFactors = FALSE)
S400_15_7_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RFModGrep/UniqueGenes/400_15_7.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.dedupgenes.txt", stringsAsFactors = FALSE)
S401_15_2_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RFModGrep/UniqueGenes/401_15_2.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.dedupgenes.txt", stringsAsFactors = FALSE)
S412_15_2_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RFModGrep/UniqueGenes/412_15_2.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.dedupgenes.txt", stringsAsFactors = FALSE)
S416_15_13_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RFModGrep/UniqueGenes/415_15_13.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.dedupgenes.txt", stringsAsFactors = FALSE)
S416_15_2_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RFModGrep/UniqueGenes/416_15_2.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.dedupgenes.txt", stringsAsFactors = FALSE)
S422_15_2_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RFModGrep/UniqueGenes/422_15_2.modgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.dedupgenes.txt", stringsAsFactors = FALSE)

S123_14_6_list<-c(S123_14_6_table$V5)
S131_14_9_list<-c(S131_14_9_table$V5)
S132_14_5_list<-c(S132_14_5_table$V5)
S153_14_2_list<-c(S153_14_2_table$V5)
S159_14_2_list<-c(S159_14_2_table$V5)
S159_14_8_list<-c(S159_14_8_table$V5)
S160_14_2_list<-c(S160_14_2_table$V5)
S176_14_2_list<-c(S176_14_2_table$V5)
S187_14_1_list<-c(S187_14_1_table$V5)
S189_14_2_list<-c(S189_14_2_table$V5)
S189_14_4_list<-c(S189_14_4_table$V5)
S400_15_2_list<-c(S400_15_2_table$V5)
S400_15_7_list<-c(S400_15_7_table$V5)
S401_15_2_list<-c(S401_15_2_table$V5)
S412_15_2_list<-c(S412_15_2_table$V5)
S416_15_13_list<-c(S416_15_13_table$V5)
S416_15_2_list<-c(S416_15_2_table$V5)
S422_15_2_list<-c(S422_15_2_table$V5)

geneList<-c(S123_14_6_list, S131_14_9_list, S132_14_5_list, S153_14_2_list,
            S159_14_2_list, S159_14_8_list, S160_14_2_list, S176_14_2_list,
            S187_14_1_list, S189_14_2_list, S189_14_4_list, S400_15_2_list,
            S400_15_7_list, S401_15_2_list, S412_15_2_list, S416_15_2_list,
            S416_15_13, S422_15_2_list)

###################################################################
## Remove all duplicated genes
###################################################################
geneList<-geneList[!duplicated(geneList)]

###################################################################
## Create empty data frame of size corresponding to gene list
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

sampleNames<-c('S123_14_6', 'S131_14_9', 'S132_14_5', 'S153_14_2',
                'S159_14_2', 'S159_14_8', 'S160_14_2', 'S176_14_2',
                'S187_14_1', 'S189_14_2', 'S189_14_4', 'S400_15_2',
                'S400_15_7', 'S401_15_2', 'S412_15_2', 'S416_15_2',
                'S416_15_13', 'S422_15_2')
            

df<-data.frame(S123_14_6, S131_14_9, S132_14_5, S153_14_2,
                S159_14_2, S159_14_8, S160_14_2, S176_14_2,
                S187_14_1, S189_14_2, S189_14_4, S400_15_2,
                S400_15_7, S401_15_2, S412_15_2, S416_15_2,
                S416_15_13, S422_15_2, Sum, row.names=geneList)

###################################################################
## Assign variants to sample object
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

write.table(ordered, file='OrderedList.txt', quote = FALSE, sep='\t')

