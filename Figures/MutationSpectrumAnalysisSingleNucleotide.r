library(ggplot2)
library(plyr)

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

# Remove all rows with more than one nucleotide in alternate allele (insertions)
for (filenum in 1:length(objs)){
  df<-as.data.frame(objs[filenum])
    for ( row in 1:length(df$sample)){
      if (nchar(as.vector(df[row, 'alt']))>1){
        df <-df[-row, ]
      }
    }

# Remove all rows with more than one nucleotide in reference allele (deletions)
  for (row in 1:length(df$sample)){
    if (nchar(as.vector(df[row, 'ref']))>1){
      df <- df[-row, ]

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
