library(ggplot2)
library(plyr)
library(reshape2)

filteredvars<-read.table(file='/Users/Christian/Documents/Forskerlinja/DMBA-indusert/Sequencing/FilteringOwnDataTests.txt', header=TRUE, sep='\t', stringsAsFactors = F)

df<-data.frame(filteredvars, stringsAsFactors = FALSE, row.names=filteredvars$Filter)
df<-df[ , !(names(df) %in% 'Filter')]

data<-df['Mutect, AD>10, AF>0.05, RF, modifier removed',]
data2<-df['Mutect, AD>10, AF>0.05, RF, modifier and synon removed',]
numeric<-as.numeric(data)
numeric2<-as.numeric(data2)
numeric2<-numeric-numeric2
variants<-data.frame(numeric, numeric2, stringsAsFactors = FALSE, row.names=colnames(df))
variants<-cbind(sample=row.names(variants), variants)
variants<-arrange(variants, numeric, row.names(variants))
variants$sample<-factor(variants$sample, levels=variants$sample)

variants1<-melt(variants, id.var='sample')

colours<-c(numeric='dodgerblue4', numeric2='black')

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
