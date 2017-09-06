library(ggplot2)
library(plyr)

S123_14_6_table<-read.table("/Volumes/open/tmp/Christian/DMBA-induced/Output/FilterTests/mm10/OnePerLineAD10AF005RFModLowGrep/UniqueCoordinates/123_14_6.mm10.modlowgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.txt", stringsAsFactors = FALSE, sep="\t")
S131_14_9_table<-read.table("/Volumes/open/tmp/Christian/DMBA-induced/Output/FilterTests/mm10/OnePerLineAD10AF005RFModLowGrep/UniqueCoordinates/131_14_9.mm10.modlowgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.txt", stringsAsFactors = FALSE, sep="\t")
S132_14_5_table<-read.table("/Volumes/open/tmp/Christian/DMBA-induced/Output/FilterTests/mm10/OnePerLineAD10AF005RFModLowGrep/UniqueCoordinates/132_14_5.mm10.modlowgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.txt", stringsAsFactors = FALSE, sep="\t")
S153_14_2_table<-read.table("/Volumes/open/tmp/Christian/DMBA-induced/Output/FilterTests/mm10/OnePerLineAD10AF005RFModLowGrep/UniqueCoordinates/153_14_2.mm10.modlowgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.txt", stringsAsFactors = FALSE, sep="\t")
S159_14_2_table<-read.table("/Volumes/open/tmp/Christian/DMBA-induced/Output/FilterTests/mm10/OnePerLineAD10AF005RFModLowGrep/UniqueCoordinates/159_14_2.mm10.modlowgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.txt", stringsAsFactors = FALSE, sep="\t")
S159_14_8_table<-read.table("/Volumes/open/tmp/Christian/DMBA-induced/Output/FilterTests/mm10/OnePerLineAD10AF005RFModLowGrep/UniqueCoordinates/159_14_8.mm10.modlowgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.txt", stringsAsFactors = FALSE, sep="\t")
S160_14_2_table<-read.table("/Volumes/open/tmp/Christian/DMBA-induced/Output/FilterTests/mm10/OnePerLineAD10AF005RFModLowGrep/UniqueCoordinates/160_14_2.mm10.modlowgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.txt", stringsAsFactors = FALSE, sep="\t")
S176_14_2_table<-read.table("/Volumes/open/tmp/Christian/DMBA-induced/Output/FilterTests/mm10/OnePerLineAD10AF005RFModLowGrep/UniqueCoordinates/176_14_2.mm10.modlowgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.txt", stringsAsFactors = FALSE, sep="\t")
S187_14_1_table<-read.table("/Volumes/open/tmp/Christian/DMBA-induced/Output/FilterTests/mm10/OnePerLineAD10AF005RFModLowGrep/UniqueCoordinates/187_14_1.mm10.modlowgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.txt", stringsAsFactors = FALSE, sep="\t")
S189_14_2_table<-read.table("/Volumes/open/tmp/Christian/DMBA-induced/Output/FilterTests/mm10/OnePerLineAD10AF005RFModLowGrep/UniqueCoordinates/189_14_2.mm10.modlowgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.txt", stringsAsFactors = FALSE, sep="\t")
S189_14_4_table<-read.table("/Volumes/open/tmp/Christian/DMBA-induced/Output/FilterTests/mm10/OnePerLineAD10AF005RFModLowGrep/UniqueCoordinates/189_14_4.mm10.modlowgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.txt", stringsAsFactors = FALSE, sep="\t")
S400_15_2_table<-read.table("/Volumes/open/tmp/Christian/DMBA-induced/Output/FilterTests/mm10/OnePerLineAD10AF005RFModLowGrep/UniqueCoordinates/400_15_2.mm10.modlowgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.txt", stringsAsFactors = FALSE, sep="\t")
S400_15_7_table<-read.table("/Volumes/open/tmp/Christian/DMBA-induced/Output/FilterTests/mm10/OnePerLineAD10AF005RFModLowGrep/UniqueCoordinates/400_15_7.mm10.modlowgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.txt", stringsAsFactors = FALSE, sep="\t")
S401_15_2_table<-read.table("/Volumes/open/tmp/Christian/DMBA-induced/Output/FilterTests/mm10/OnePerLineAD10AF005RFModLowGrep/UniqueCoordinates/401_15_2.mm10.modlowgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.txt", stringsAsFactors = FALSE, sep="\t")
S412_15_2_table<-read.table("/Volumes/open/tmp/Christian/DMBA-induced/Output/FilterTests/mm10/OnePerLineAD10AF005RFModLowGrep/UniqueCoordinates/412_15_2.mm10.modlowgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.txt", stringsAsFactors = FALSE, sep="\t")
S416_15_13_table<-read.table("/Volumes/open/tmp/Christian/DMBA-induced/Output/FilterTests/mm10/OnePerLineAD10AF005RFModLowGrep/UniqueCoordinates/415_15_13.mm10.modlowgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.txt", stringsAsFactors = FALSE, sep="\t")
S416_15_2_table<-read.table("/Volumes/open/tmp/Christian/DMBA-induced/Output/FilterTests/mm10/OnePerLineAD10AF005RFModLowGrep/UniqueCoordinates/416_15_2.mm10.modlowgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.txt", stringsAsFactors = FALSE, sep="\t")
S422_15_2_table<-read.table("/Volumes/open/tmp/Christian/DMBA-induced/Output/FilterTests/mm10/OnePerLineAD10AF005RFModLowGrep/UniqueCoordinates/422_15_2.mm10.modlowgrepAD10AF005FR.annotated.passfiltered.extracted.modgrep.dedup.txt", stringsAsFactors = FALSE, sep="\t")

# Create data frame with sample name, reference allele and alternate allele
df1<-data.frame(sample=c(rep('S123_14_6', times=(length(S123_14_6_table$V3)))), ref=S123_14_6_table$V3, alt=S123_14_6_table$V4)
df2<-data.frame(sample=c(rep('S131_14_9', times=(length(S131_14_9_table$V3)))), ref=S131_14_9_table$V3, alt=S131_14_9_table$V4)
df3<-data.frame(sample=c(rep('S132_14_5', times=(length(S132_14_5_table$V3)))), ref=S132_14_5_table$V3, alt=S132_14_5_table$V4)
df4<-data.frame(sample=c(rep('S153_14_2', times=(length(S153_14_2_table$V3)))), ref=S153_14_2_table$V3, alt=S153_14_2_table$V4)
df5<-data.frame(sample=c(rep('S159_14_2', times=(length(S159_14_2_table$V3)))), ref=S159_14_2_table$V3, alt=S159_14_2_table$V4)
df6<-data.frame(sample=c(rep('S159_14_8', times=(length(S159_14_8_table$V3)))), ref=S159_14_8_table$V3, alt=S159_14_8_table$V4)
df7<-data.frame(sample=c(rep('S160_14_2', times=(length(S160_14_2_table$V3)))), ref=S160_14_2_table$V3, alt=S160_14_2_table$V4)
df8<-data.frame(sample=c(rep('S176_14_2', times=(length(S176_14_2_table$V3)))), ref=S176_14_2_table$V3, alt=S176_14_2_table$V4)
df9<-data.frame(sample=c(rep('S187_14_1', times=(length(S187_14_1_table$V3)))), ref=S187_14_1_table$V3, alt=S187_14_1_table$V4)
df10<-data.frame(sample=c(rep('S189_14_2', times=(length(S189_14_2_table$V3)))), ref=S189_14_2_table$V3, alt=S189_14_2_table$V4)
df11<-data.frame(sample=c(rep('S189_14_4', times=(length(S189_14_4_table$V3)))), ref=S189_14_4_table$V3, alt=S189_14_4_table$V4)
df12<-data.frame(sample=c(rep('S400_15_2', times=(length(S400_15_2_table$V3)))), ref=S400_15_2_table$V3, alt=S400_15_2_table$V4)
df13<-data.frame(sample=c(rep('S400_15_7', times=(length(S400_15_7_table$V3)))), ref=S400_15_7_table$V3, alt=S400_15_7_table$V4)
df14<-data.frame(sample=c(rep('S401_15_2', times=(length(S401_15_2_table$V3)))), ref=S401_15_2_table$V3, alt=S401_15_2_table$V4)
df15<-data.frame(sample=c(rep('S412_15_2', times=(length(S412_15_2_table$V3)))), ref=S412_15_2_table$V3, alt=S412_15_2_table$V4)
df16<-data.frame(sample=c(rep('S416_15_13', times=(length(S416_15_13_table$V3)))), ref=S416_15_13_table$V3, alt=S416_15_13_table$V4)
df17<-data.frame(sample=c(rep('S416_15_2', times=(length(S416_15_2_table$V3)))), ref=S416_15_2_table$V3, alt=S416_15_2_table$V4)
df18<-data.frame(sample=c(rep('S422_15_2', times=(length(S422_15_2_table$V3)))), ref=S422_15_2_table$V3, alt=S422_15_2_table$V4)

objs<-list(df1, df2, df3, df4, df5, df6, df7, df8, df9, df10, df11, df12,
           df13, df14, df15, df16, df17, df18)

TsTvs<-0

# Remove all rows with more than one nucleotide in alternate allele (insertions)
for (filenum in 1:length(objs)){
  df<-as.data.frame(objs[filenum])
  for (row in 1:length(df$sample)){
    
    # The length of the data frame is set at the start, yet rows are removed continuously. This stops an error from being thrown once the end of the data frame is reached.
    if (is.na(df[row, 'alt']) == TRUE){
      next
    }
    
    if (nchar(as.vector(df[row, 'alt']))>1){
      df <-df[-row, ]
      TsTvs =TsTvs + 1
      
      #If a row is removed, the script continues onto the next row, and the row that has replaced the current row is therefore ignored. This places a second iteration within the first iteration so that the next row is checked. This is an issue if two indels are after eachother in the input. The second iteration solves this. An error will be thrown if three indels are placed after another. This is a shameful, hacky solution.
      if (is.na(df[row, 'alt']) == TRUE){
        next
      }
      
      if (nchar(as.vector(df[row, 'alt']))>1){
        df <-df[-row, ]
        TsTvs =TsTvs + 1
      }
    }
  }
  
  # Remove all rows with more than one nucleotide in reference allele (deletions)
  for (row in 1:length(df$sample)){
    
    if (is.na(df[row, 'ref']) == TRUE){
      next
    }
    
    if (nchar(as.vector(df[row, 'ref']))>1){
      df <- df[-row, ]
      TsTvs = TsTvs + 1
      
      if (is.na(df[row, 'alt']) == TRUE){
        next
      }
      
      if (nchar(as.vector(df[row, 'ref']))>1){
        df <- df[-row, ]
        TsTvs = TsTvs + 1
      }
    }
  }
  
  # Convert all refs to pyrimidines (C & T) according to convention
  for (row in 1:length(df$sample)){
    if (df[row, 'ref']=='A'){
      df[row, 'ref']<-'T'
      
      if (df[row, 'alt']=='T'){
        df[row, 'alt'] <- 'A'
        next
      }
      
      if (df[row, 'alt']=='G'){
        df[row, 'alt'] <- 'C'
        next
      }
      
      if (df[row, 'alt']=='C'){
        df[row, 'alt'] <- 'G'
        next
      }
    }
    
    if (df[row, 'ref']=='G'){
      df[row, 'ref']<-'C'
      
      if (df[row, 'alt']=='T'){
        df[row, 'alt'] <- 'A'
        next
      }
      
      if (df[row, 'alt']=='A'){
        df[row, 'alt'] <- 'T'
        next
      }
      
      if (df[row, 'alt']=='C'){
        df[row, 'alt'] <- 'G'
        next
      }
    }
  }
  
  # Create new column in df with transition type
  for (row in 1:length(df$sample)){
    df[row, 'TS']<-paste(df[row, 'ref'], df[row, 'alt'], sep='>')
  }
  
  # Create new df with transition type as a proportion
  freqs<-count(as.factor(df$TS))
  proportion<-freqs[1:6, 'freq']/length(df$TS)
  
  propdf<-data.frame(sample=rep(df[1,1], times=6), TS=freqs$x, proportion=proportion)
  
  assign(paste('sample', filenum, sep=''), propdf)
}

bound<-rbind(sample1, sample2, sample3, sample4, sample5, sample6, sample7,
             sample8, sample9, sample10, sample11, sample12, sample13,
             sample14, sample15, sample16, sample17, sample18)


plotdata<-ggplot(bound,aes(x=factor(sample),y=rev(proportion),fill=factor(TS)), color=factor(TS))

chart<-plotdata + stat_summary(fun.y=mean,position="stack",geom="bar") +
  theme(axis.title.x=element_blank(),
        axis.line.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.text.x=element_text(angle=90),
        panel.background = element_rect(fill = "white"),
        legend.title=element_blank()) +
  labs(y='Proportion of substitutions') +
  scale_y_continuous(limits = c(0,1), expand = c(0, 0))

print(chart)