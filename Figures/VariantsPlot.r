library('ggplot2')
library('cowplot')

file<-read.table(file='/Volumes/Christian/DMBA-induced/Output/Analysis/VogelsteinSelectedModLowGrep.txt')

sampleNames<-c('S123_14_6', 'S131_14_9', 'S132_14_5', 'S153_14_2',
               'S159_14_2', 'S159_14_8', 'S160_14_2', 'S176_14_2',
               'S187_14_1', 'S189_14_2', 'S189_14_4', 'S400_15_2',
               'S400_15_7', 'S401_15_2', 'S412_15_2', 'S416_15_2',
               'S416_15_13', 'S422_15_2')

df<-data.frame(file)
geneLabs<-row.names(df)


samples<-c(rep(sampleNames[1], times=length(geneLabs)))
for (a in 2:length(sampleNames)) {
 samples<-c(samples, c(rep(sampleNames[a], times=length(geneLabs)))) 
 }

genes<-c(rep(1:72, times=length(sampleNames)))


         

contains<-c(file[,1])
for (b in 2:length(sampleNames)){
  contains<-c(contains, c(file[ ,b]))
}

df<-data.frame(samples, genes, contains)



plotdata<-ggplot(data=df, aes(x=samples, y=rev(genes), fill=contains))

chart<-plotdata+geom_raster() + 
  theme(axis.text.x=element_text(size=14, face='bold', angle=270, hjust=-1),
        axis.text.y=element_text(size=10, face='italic', hjust=0),
        axis.ticks.x=element_blank(), axis.ticks.y=element_blank(),
        panel.background=element_rect(fill='#ffffff'),
        axis.line=element_blank(),
        legend.position='none') +
  scale_y_continuous('Genes', breaks=1:length(geneLabs), labels=rev(geneLabs)) +
  scale_x_discrete("Sample") + 
  scale_fill_gradient(low='grey87', high='dodgerblue4') +
  geom_vline(xintercept = seq(1.5, (length(sampleNames)+0.5), by=1), color = "white", size = 0.5) +
  geom_hline(yintercept = seq(1.5, (length(geneLabs)+0.5), by=1), color = "white", size = 0.5)
  

print(chart)


