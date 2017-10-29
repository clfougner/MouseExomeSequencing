
#########################################################################
## Create list of all genes (must have passed through ModGrepPipeline.sh)
#########################################################################
setwd("/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/AnalysisResults_w50k/Results/Intersect/")
S123_14_6_table<-read.table("S123_14_6_CNA_0.95_annotated.txt", stringsAsFactors = FALSE, header=TRUE)
S131_14_9_table<-read.table("S131_14_9_CNA_0.95_annotated.txt", stringsAsFactors = FALSE, header=TRUE)
S132_14_5_table<-read.table("S132_14_5_CNA_0.95_annotated.txt", stringsAsFactors = FALSE, header=TRUE)
S153_14_2_table<-read.table("S153_14_2_CNA_0.95_annotated.txt", stringsAsFactors = FALSE, header=TRUE)
S159_14_2_table<-read.table("S159_14_2_CNA_0.95_annotated.txt", stringsAsFactors = FALSE, header=TRUE)
S159_14_8_table<-read.table("S159_14_8_CNA_0.95_annotated.txt", stringsAsFactors = FALSE, header=TRUE)
S160_14_2_table<-read.table("S160_14_2_CNA_0.95_annotated.txt", stringsAsFactors = FALSE, header=TRUE)
S176_14_2_table<-read.table("S176_14_2_CNA_0.95_annotated.txt", stringsAsFactors = FALSE, header=TRUE)
S187_14_1_table<-read.table("S187_14_1_CNA_0.95_annotated.txt", stringsAsFactors = FALSE, header=TRUE)
S189_14_2_table<-read.table("S189_14_2_CNA_0.95_annotated.txt", stringsAsFactors = FALSE, header=TRUE)
S189_14_4_table<-read.table("S189_14_4_CNA_0.95_annotated.txt", stringsAsFactors = FALSE, header=TRUE)
S400_15_2_table<-read.table("S400_15_2_CNA_0.95_annotated.txt", stringsAsFactors = FALSE, header=TRUE)
S400_15_7_table<-read.table("S400_15_7_CNA_0.95_annotated.txt", stringsAsFactors = FALSE, header=TRUE)
S401_15_2_table<-read.table("S401_15_2_CNA_0.95_annotated.txt", stringsAsFactors = FALSE, header=TRUE)
S412_15_2_table<-read.table("S412_15_2_CNA_0.95_annotated.txt", stringsAsFactors = FALSE, header=TRUE)
S416_15_13_table<-read.table("S416_15_13_CNA_0.95_annotated.txt", stringsAsFactors = FALSE, header=TRUE)
S416_15_2_table<-read.table("S416_15_2_CNA_0.95_annotated.txt", stringsAsFactors = FALSE, header=TRUE)
S422_15_2_table<-read.table("S422_15_2_CNA_0.95_annotated.txt", stringsAsFactors = FALSE, header=TRUE)

S123_14_6_table = S123_14_6_table[!duplicated(S123_14_6_table$geneName),]
S131_14_9_table = S131_14_9_table[!duplicated(S131_14_9_table$geneName),]
S132_14_5_table = S132_14_5_table[!duplicated(S132_14_5_table$geneName),]
S153_14_2_table = S153_14_2_table[!duplicated(S153_14_2_table$geneName),]
S159_14_2_table = S159_14_2_table[!duplicated(S159_14_2_table$geneName),]
S159_14_8_table = S159_14_8_table[!duplicated(S159_14_8_table$geneName),]
S160_14_2_table = S160_14_2_table[!duplicated(S160_14_2_table$geneName),]
S176_14_2_table = S176_14_2_table[!duplicated(S176_14_2_table$geneName),]
S187_14_1_table = S187_14_1_table[!duplicated(S187_14_1_table$geneName),]
S189_14_2_table = S189_14_2_table[!duplicated(S189_14_2_table$geneName),]
S189_14_4_table = S189_14_4_table[!duplicated(S189_14_4_table$geneName),]
S400_15_2_table = S400_15_2_table[!duplicated(S400_15_2_table$geneName),]
S400_15_7_table = S400_15_7_table[!duplicated(S400_15_7_table$geneName),]
S401_15_2_table = S401_15_2_table[!duplicated(S401_15_2_table$geneName),]
S412_15_2_table = S412_15_2_table[!duplicated(S412_15_2_table$geneName),]
S416_15_13_table = S416_15_13_table[!duplicated(S416_15_13_table$geneName),]
S416_15_2_table = S416_15_2_table[!duplicated(S416_15_2_table$geneName),]
S422_15_2_table = S422_15_2_table[!duplicated(S422_15_2_table$geneName),]

#########################################################################
## Create data frame for each sample with row names set to gene names
## and data set to effect type (LOW, MODERATE, HIGH)
#########################################################################
S123_14_6_df<-data.frame(S123_14_6_table$CNA, row.names = S123_14_6_table$geneName, stringsAsFactors = FALSE)
S131_14_9_df<-data.frame(S131_14_9_table$CNA, row.names = S131_14_9_table$geneName, stringsAsFactors = FALSE)
S132_14_5_df<-data.frame(S132_14_5_table$CNA, row.names = S132_14_5_table$geneName, stringsAsFactors = FALSE)
S153_14_2_df<-data.frame(S153_14_2_table$CNA, row.names = S153_14_2_table$geneName, stringsAsFactors = FALSE)
S159_14_2_df<-data.frame(S159_14_2_table$CNA, row.names = S159_14_2_table$geneName, stringsAsFactors = FALSE)
S159_14_8_df<-data.frame(S159_14_8_table$CNA, row.names = S159_14_8_table$geneName, stringsAsFactors = FALSE)
S160_14_2_df<-data.frame(S160_14_2_table$CNA, row.names = S160_14_2_table$geneName, stringsAsFactors = FALSE)
S176_14_2_df<-data.frame(S176_14_2_table$CNA, row.names = S176_14_2_table$geneName, stringsAsFactors = FALSE)
S187_14_1_df<-data.frame(S187_14_1_table$CNA, row.names = S187_14_1_table$geneName, stringsAsFactors = FALSE)
S189_14_2_df<-data.frame(S189_14_2_table$CNA, row.names = S189_14_2_table$geneName, stringsAsFactors = FALSE)
S189_14_4_df<-data.frame(S189_14_4_table$CNA, row.names = S189_14_4_table$geneName, stringsAsFactors = FALSE)
S400_15_2_df<-data.frame(S400_15_2_table$CNA, row.names = S400_15_2_table$geneName, stringsAsFactors = FALSE)
S400_15_7_df<-data.frame(S400_15_7_table$CNA, row.names = S400_15_7_table$geneName, stringsAsFactors = FALSE)
S401_15_2_df<-data.frame(S401_15_2_table$CNA, row.names = S401_15_2_table$geneName, stringsAsFactors = FALSE)
S412_15_2_df<-data.frame(S412_15_2_table$CNA, row.names = S412_15_2_table$geneName, stringsAsFactors = FALSE)
S416_15_13_df<-data.frame(S416_15_13_table$CNA, row.names = S416_15_13_table$geneName, stringsAsFactors = FALSE)
S416_15_2_df<-data.frame(S416_15_2_table$CNA, row.names = S416_15_2_table$geneName, stringsAsFactors = FALSE)
S422_15_2_df<-data.frame(S422_15_2_table$CNA, row.names = S422_15_2_table$geneName, stringsAsFactors = FALSE)

#########################################################################
## Create list of all sample names
#########################################################################
sampleNames<-c('S123_14_6', 'S131_14_9', 'S132_14_5', 'S153_14_2',
               'S159_14_2', 'S159_14_8', 'S160_14_2', 'S176_14_2',
               'S187_14_1', 'S189_14_2', 'S189_14_4', 'S400_15_2',
               'S400_15_7', 'S401_15_2', 'S412_15_2', 'S416_15_2',
               'S416_15_13', 'S422_15_2')

#########################################################################
## Create list of all genes with variants in the given sample
#########################################################################
S123_14_6_list<-c(S123_14_6_table$geneName)
S131_14_9_list<-c(S131_14_9_table$geneName)
S132_14_5_list<-c(S132_14_5_table$geneName)
S153_14_2_list<-c(S153_14_2_table$geneName)
S159_14_2_list<-c(S159_14_2_table$geneName)
S159_14_8_list<-c(S159_14_8_table$geneName)
S160_14_2_list<-c(S160_14_2_table$geneName)
S176_14_2_list<-c(S176_14_2_table$geneName)
S187_14_1_list<-c(S187_14_1_table$geneName)
S189_14_2_list<-c(S189_14_2_table$geneName)
S189_14_4_list<-c(S189_14_4_table$geneName)
S400_15_2_list<-c(S400_15_2_table$geneName)
S400_15_7_list<-c(S400_15_7_table$geneName)
S401_15_2_list<-c(S401_15_2_table$geneName)
S412_15_2_list<-c(S412_15_2_table$geneName)
S416_15_13_list<-c(S416_15_13_table$geneName)
S416_15_2_list<-c(S416_15_2_table$geneName)
S422_15_2_list<-c(S422_15_2_table$geneName)

#########################################################################
## Concatenate all lists into one
#########################################################################
geneList<-c(S123_14_6_list, S131_14_9_list, S132_14_5_list, S153_14_2_list,
            S159_14_2_list, S159_14_8_list, S160_14_2_list, S176_14_2_list,
            S187_14_1_list, S189_14_2_list, S189_14_4_list, S400_15_2_list,
            S400_15_7_list, S401_15_2_list, S412_15_2_list, S416_15_2_list,
            S416_15_13_list, S422_15_2_list)

###################################################################
## Remove all duplicated genes
###################################################################
geneList<-geneList[!duplicated(geneList)]

###################################################################
## Create empty data frame of size corresponding to gene list 
## (Important: object names must be identical to sample name in the
## sampleNames object)
###################################################################
numGenes<-length(geneList)
S123_14_6<-rep(NA, times=numGenes)
S131_14_9<-rep(NA, times=numGenes)
S132_14_5<-rep(NA, times=numGenes)
S153_14_2<-rep(NA, times=numGenes)
S159_14_2<-rep(NA, times=numGenes)
S159_14_8<-rep(NA, times=numGenes)
S160_14_2<-rep(NA, times=numGenes)
S176_14_2<-rep(NA, times=numGenes)
S187_14_1<-rep(NA, times=numGenes)
S189_14_2<-rep(NA, times=numGenes)
S189_14_4<-rep(NA, times=numGenes)
S400_15_2<-rep(NA, times=numGenes)
S400_15_7<-rep(NA, times=numGenes)
S401_15_2<-rep(NA, times=numGenes)
S412_15_2<-rep(NA, times=numGenes)
S416_15_2<-rep(NA, times=numGenes)
S416_15_13<-rep(NA, times=numGenes)
S422_15_2<-rep(NA, times=numGenes)
Sum<-rep(NA, times=numGenes)

df<-data.frame(S123_14_6, S131_14_9, S132_14_5, S153_14_2,
               S159_14_2, S159_14_8, S160_14_2, S176_14_2,
               S187_14_1, S189_14_2, S189_14_4, S400_15_2,
               S400_15_7, S401_15_2, S412_15_2, S416_15_2,
               S416_15_13, S422_15_2, Sum, row.names=geneList)

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
## Set given data position value to effect type if variant exists
## for given sample and gene
###################################################################

for (sample in sampleNames)
{
  for (gene in geneList)
  {
    if (gene %in% eval(parse(text=sample)))
    {
      pasted<-paste(sample, '_df', sep='')
      impact<-eval(parse(text=pasted))[gene,]
      df[gene,sample]<-impact
    }
  }
}

###################################################################
## Calculate sum of samples with variant
###################################################################
sum<-rowSums(!is.na(df))
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
write.table(ordered, file='/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/AnalysisResults_w50k/CollatedAmpDelList.txt', quote = FALSE, sep='\t')

