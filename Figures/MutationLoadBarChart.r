library(ggplot2)
library(plyr)

filteredvars<-read.table(file='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/FilteringOwnDataTests.txt', header=TRUE, sep='\t', stringsAsFactors = F)

df<-data.frame(filteredvars, stringsAsFactors = F, row.names=filteredvars$Filter)
df<-df[ , !(names(df) %in% 'Filter')]

data<-df['Mutect, AD>10, AF>0.05, RF, modifier removed,',]
numeric<-as.numeric(data)
variants<-data.frame(numeric, stringsAsFactors = FALSE, row.names=colnames(df))
variants<-cbind(sample=row.names(variants), variants)
variants<-arrange(variants, numeric, row.names(variants))
variants$sample<-factor(variants$sample, levels=variants$sample)


plotdata<-ggplot(variants, aes(x=sample, y=numeric))
chart<-plotdata+geom_bar(stat='identity', width=0.9, fill='dodgerblue4') + 
        theme(axis.text=element_text(size=12, face='bold', angle=30, hjust=1), 
              axis.title=element_text(size=14, face='bold'),
              plot.title=element_text(size=18, face='bold')) +
        labs(title='Variants per sample', x='Sample', y='Variants')
print(chart)
