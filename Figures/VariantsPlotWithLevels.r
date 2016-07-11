library('ggplot2')
library('cowplot')

##################################################################
## Read file from CommonGeneListDetails.r -> FilterForVogelstein.r
##################################################################
file<-read.table(file='/Volumes/christian/DMBA-induced/Output/OrderedListVogelFiltered.txt', stringsAsFactors=FALSE)

sampleNames<-c('S123_14_6 ', 'S131_14_9 ', 'S132_14_5 ', 'S153_14_2 ',
               'S159_14_2 ', 'S159_14_8 ', 'S160_14_2 ', 'S176_14_2 ',
               'S187_14_1 ', 'S189_14_2 ', 'S189_14_4 ', 'S400_15_2 ',
               'S400_15_7 ', 'S401_15_2 ', 'S412_15_2 ', 'S416_15_2 ',
               'S416_15_13', 'S422_15_2 ')

df<-data.frame(file)
geneLabs<-row.names(df)


samples<-c(rep(sampleNames[1], times=length(geneLabs)))
for (a in 2:length(sampleNames)) {
 samples<-c(samples, c(rep(sampleNames[a], times=length(geneLabs)))) 
 }

genes<-c(rep(1:length(geneLabs), times=length(sampleNames)))


         

contains<-c(file[,1])
for (b in 2:length(sampleNames)){
  contains<-c(contains, c(file[ ,b]))
}

df<-data.frame(samples, genes, contains)
df$contains<-factor(df$contains, levels=c('HIGH','MODERATE','LOW'))
df$samples<-factor(df$samples, levels=c('S159_14_8 ', 'S400_15_7 ', 'S401_15_2 ', 'S189_14_2 ',
                                        'S176_14_2 ', 'S153_14_2 ','S400_15_2 ', 'S416_15_13',
                                        'S160_14_2 ', 'S159_14_2 ', 'S123_14_6 ', 'S412_15_2 ',
                                        'S187_14_1 ', 'S422_15_2 ', 'S416_15_2 ','S189_14_4 ', 
                                        'S132_14_5 ',  'S131_14_9 '))

plotdata<-ggplot(data=df, aes(x=samples, y=rev(genes), fill=contains))

chart<-plotdata+geom_raster() + 
       ylab('') +
    theme(axis.title.y=element_blank(),
          axis.title.x=element_text(size=0),
          axis.text.y=element_text(size=10, face='italic', hjust=1),
          axis.text.x=element_text(size=14, face='bold', angle=270, hjust=-1),
          axis.line=element_blank(),
          panel.background=element_rect(fill='#ffffff'),
          axis.ticks.y=element_blank(),
          axis.ticks.x=element_line(colour='white')) +
    scale_y_continuous('Genes', breaks=1:length(geneLabs), labels=rev(geneLabs)) +
    geom_vline(xintercept = seq(1.5, (length(sampleNames)+0.5), by=1), color = "white", size = 0.5) +
    geom_hline(yintercept = seq(1.5, (length(geneLabs)+0.5), by=1), color = "white", size = 0.5) +
    scale_fill_manual(values=c('red3', 'dodgerblue4', 'forestgreen'), na.value='grey85', name='Variant effect') 
  

chart2<-ggdraw(switch_axis_position(chart, axis='x'))
print(chart2)


