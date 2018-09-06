library(ggplot2)
library(gridExtra)

setwd("/Users/christianfougner/Documents/Forskning/DMBA-prosjekt/Sequencing/")

mutData<-read.table(file="MostFreqMutDMBA.txt", sep="\t", header = TRUE)

midpoint<-(length(mutData$Gene)/2)+1
topNGenes<-21
mutData<-rbind(mutData[1:topNGenes, ], mutData[midpoint:(midpoint+topNGenes-1), ])



mutations<-ggplot(mutData, aes(x=Gene, y=PctMut, fill = Set))

p1<-mutationsTCGA+geom_bar(width=0.85, stat='identity', position = position_dodge(width=0.85)) +
  theme(axis.text.x=element_text(size=12, angle=90, hjust=1, vjust = 0.5),
        axis.text.y=element_text(size=12),
        panel.background = element_rect(fill = "transparent",colour = NA),
        panel.grid.minor = element_blank(), 
        panel.grid.major = element_blank(),
        plot.background = element_rect(fill = "transparent",colour = NA),
        axis.line = element_line()) +
  labs(title='', x='Gene', y='Proportion Mutated', fill="") +
  scale_fill_hue(labels=c("MPA/DMBA-induced", "Human Breast Cancer")) +
  scale_x_discrete(limits=unique(mutData$Gene))


### TCGA
mutDataTCGA<-read.table(file="MostFreqMutTCGA.txt", sep="\t", header = TRUE)

midpointTCGA<-(length(mutDataTCGA$Gene)/2)+1
mutDataTCGA<-rbind(mutDataTCGA[1:topNGenes, ], mutDataTCGA[midpointTCGA:(midpointTCGA+topNGenes-1), ])

mutationsTCGA<-ggplot(mutDataTCGA, aes(x=Gene, y=PctMut, fill = Set))

p1<-mutationsTCGA+geom_bar(width=0.85, stat='identity', position = position_dodge(width=0.85)) +
  theme(axis.text.x=element_text(size=12, angle=90, hjust=1, vjust = 0.5),
        axis.text.y=element_text(size=12),
        panel.background = element_rect(fill = "transparent",colour = NA),
        panel.grid.minor = element_blank(), 
        panel.grid.major = element_blank(),
        plot.background = element_rect(fill = "transparent",colour = NA),
        axis.line = element_line()) +
  labs(title='', x='Gene', y='Proportion Mutated', fill="") +
  scale_fill_hue(labels=c("MPA/DMBA-induced", "Human Breast Cancer")) +
  scale_x_discrete(limits=unique(mutDataTCGA$Gene)) 
  


grid.arrange(p1, p2, nrow = 2)
