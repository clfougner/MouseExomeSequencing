library(ggplot2)
library(plyr)
library(reshape2)

#########################################################################################
## Read table with the list number of variants per sample in the wide format (output from 
## ModGrepPipeline.sh "wc -l" command)
#########################################################################################
filteredvars<-read.table(file='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/FilteringOwnDataTests.txt', header=TRUE, sep='\t', stringsAsFactors = F)

#########################################################################################
## Make data.frame of file, remove the first column and set to row names
#########################################################################################
df<-data.frame(filteredvars, stringsAsFactors = FALSE, row.names=filteredvars$Filter)
df<-df[ , !(names(df) %in% 'Filter')]

#########################################################################################
## Select row
#########################################################################################
data<-df['Mutect, AD>10, AF>0.05, RF, modifier removed',]
data2<-df['Mutect, AD>10, AF>0.05, RF, modifier and synon removed',]

#########################################################################################
## Find difference between two rows
#########################################################################################
numeric<-as.numeric(data)
numeric2<-as.numeric(data2)
numeric2<-numeric-numeric2
numeric<-as.numeric(data2)
forOrder<-as.numeric(data)

#########################################################################################
## First step for converting to long format (required for ggplot2)
#########################################################################################
variants<-data.frame(numeric, numeric2, stringsAsFactors = FALSE, row.names=colnames(df))
variants<-cbind(sample=row.names(variants), variants)

#########################################################################################
## Order files by number of variants
#########################################################################################
variants<-arrange(variants, forOrder, row.names(variants))
variants$sample<-factor(variants$sample, levels=variants$sample)

#########################################################################################
## Second step for converting to long format
#########################################################################################
variants1<-melt(variants, id.var='sample')


#########################################################################################
## Create plot
#########################################################################################
plotdata<-ggplot(variants1, aes(x=sample, y=value, fill=variable))
chart<-plotdata+geom_bar(stat='identity', width=0.9) +
      theme_grey() +
      theme(axis.text.x=element_text(size=14, face='bold', angle=90, hjust=1),
            axis.text.y=element_text(size=12, hjust=0),
            axis.ticks.x=element_blank(),
            plot.title=element_text(size=18, face='bold'),
            legend.title=element_blank()) +
      labs(title='Variants per sample', x='Sample', y='Variants') +
      scale_fill_manual(labels=c('Non-synonymous variants', 'Synonymous variants'), 
                        values=c('dodgerblue4', "turquoise4"))
       
       
print(chart)
