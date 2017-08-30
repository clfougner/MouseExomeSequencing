library(ggplot2)
library(plyr)

#########################################################################################
## Read table with the list number of variants per sample in the wide format (output from 
## ModGrepPipeline.sh "wc -l" command)
#########################################################################################
filteredvars<-read.table(file='/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/FilteringOwnDataTests.txt', header=TRUE, sep='\t', stringsAsFactors = F)

#########################################################################################
## Make data.frame of file, remove the first column and set to row names
#########################################################################################
df<-data.frame(filteredvars, stringsAsFactors = FALSE, row.names=filteredvars$Filter)
df<-df[ , !(names(df) %in% 'Filter')]

#########################################################################################
## Select row
#########################################################################################
data<-df['Mutect, AD>10, AF>0.05, RF, modifier removed,',]

#########################################################################################
## Convert to long format (required for ggplot2)
#########################################################################################
numeric<-as.numeric(data)
variants<-data.frame(numeric, stringsAsFactors = FALSE, row.names=colnames(df))
variants<-cbind(sample=row.names(variants), variants)

#########################################################################################
## Order files by number of variants
#########################################################################################
variants<-arrange(variants, numeric, row.names(variants))
variants$sample<-factor(variants$sample, levels=variants$sample)

#########################################################################################
## Create plot
#########################################################################################
plotdata<-ggplot(variants, aes(x=sample, y=numeric))
chart<-plotdata+geom_bar(stat='identity', width=0.9, fill='dodgerblue4') + 
        theme(axis.text=element_text(size=12, face='bold', angle=30, hjust=1), 
              axis.title=element_text(size=14, face='bold'),
              plot.title=element_text(size=18, face='bold')) +
        labs(title='Variants per sample', x='Sample', y='Variants')
print(chart)
