# Multiple plot function
#
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
#
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots == 1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}

library(ggplot2)
library(plyr)
library(reshape2)

sampleNames <- c('S123_14_6 ', 'S131_14_9 ', 'S132_14_5 ', 'S153_14_2 ',
               'S159_14_2 ', 'S159_14_8 ', 'S160_14_2 ', 'S176_14_2 ',
               'S187_14_1 ', 'S189_14_2 ', 'S189_14_4 ', 'S400_15_2 ',
               'S400_15_7 ', 'S401_15_2 ', 'S412_15_2 ', 'S416_15_2 ',
               'S416_15_13', 'S422_15_2 ')

#########################################################################################
## Read table with the list number of variants per sample in the wide format (output from 
## ModGrepPipeline.sh "wc -l" command)
#########################################################################################
filteredvars <- read.table(file = '/Users/christianfougner/Documents/Forskning/DMBA-prosjekt/Sequencing/FilteringOwnDataTests.txt', header = TRUE, sep = '\t', stringsAsFactors = F)

#########################################################################################
## Make data.frame of file, remove the first column and set to row names
#########################################################################################
df <- data.frame(filteredvars, stringsAsFactors = FALSE, row.names = filteredvars$Filter)
df <- df[ , !(names(df) %in% 'Filter')]

#########################################################################################
## Select row
#########################################################################################
data <- df['mm10, Mutect, AD>10, AF>0.05, RF, modifier removed',]
data2 <- df['mm10, Mutect, AD>10, AF>0.05, RF, modifier and synonymous removed',]

#########################################################################################
## Find difference between two rows
#########################################################################################
numeric <- as.numeric(data)
numeric2 <- as.numeric(data2)
numeric2 <- numeric - numeric2
numeric <- as.numeric(data2)
forOrder <- as.numeric(data)

#########################################################################################
## First step for converting to long format (required for ggplot2)
#########################################################################################
variants <- data.frame("Non-synonymous mutations" = numeric2, "Synonymous mutations" = numeric, stringsAsFactors = FALSE, row.names = colnames(df))
variants <- cbind(sample = row.names(variants), variants)

#########################################################################################
## Order files by number of variants
#########################################################################################
variants <- arrange(variants, forOrder, row.names(variants))
variants$sample <- factor(variants$sample, levels = variants$sample)

#########################################################################################
## Second step for converting to long format
#########################################################################################
variants1 <- melt(variants, id.var = 'sample')
variants1 <- rev(variants1)

#########################################################################################fill=factor(y, levels=c("blue","white" ))
## Create plot
#########################################################################################
plotdata <- ggplot(variants1, aes(x = sample, y = value, fill = variable))
VPSplot <- plotdata + geom_bar(stat = 'identity', width = 0.9) +
  theme_grey() +
  theme(axis.text.x = element_blank(),
        axis.text.y = element_text(size = 8, hjust = 0),
        axis.ticks.x = element_blank(),
        panel.grid = element_blank(),
        plot.title = element_text(size = 8, face = 'bold'),
        plot.margin = unit(c(-0.5, 0.1, 0, 0.065), "cm"),
        legend.title = element_blank()) +
  geom_vline(xintercept = seq(1.5, (length(sampleNames) + 0.5), by = 1), color = "white", size = 0.6) +
  labs(y = 'Number of Mutations', x = '') +
  scale_fill_manual(labels = c('Synonymous mutations', 'Non-synonymous mutations'), 
                    values = c("turquoise4", "dodgerblue4"))




library('ggplot2')
#library('cowplot')

#########################################################################################
## Read file for CommonGeneListSpecific.r -> FilterForVogelstein.r
#########################################################################################
file <- read.table(file = '/Users/christianfougner/Documents/Forskning/DMBA-prosjekt/Sequencing/Output/FinalOut/VariantsForRaster.txt', stringsAsFactors = FALSE)

#########################################################################################
## Sample names in same order as input file
#########################################################################################
sampleNames <- c('S123_14_6 ', 'S131_14_9 ', 'S132_14_5 ', 'S153_14_2 ',
               'S159_14_2 ', 'S159_14_8 ', 'S160_14_2 ', 'S176_14_2 ',
               'S187_14_1 ', 'S189_14_2 ', 'S189_14_4 ', 'S400_15_2 ',
               'S400_15_7 ', 'S401_15_2 ', 'S412_15_2 ', 'S416_15_2 ',
               'S416_15_13', 'S422_15_2 ')

#########################################################################################
## Create data frame of input file
#########################################################################################
df <- data.frame(file)

#########################################################################################
## Create list of gene names (row names in input file)
#########################################################################################
geneLabs <- row.names(df)

#########################################################################################
## Create list of sample names in the form of: sample1(repeat*number of genes), sample2(
## repeat*number of genes)... sampleN(repeat*number of genes) Required for making data in
## long format
#########################################################################################
samples <- c(rep(sampleNames[1], times = length(geneLabs)))
for (a in 2:length(sampleNames)) {
  samples <- c(samples, c(rep(sampleNames[a], times = length(geneLabs)))) 
}

#########################################################################################
## Create list of genes in the form of: (gene1, gene2, gene3... geneN)(repeat*number of 
## samples) .Required for making data in long format
#########################################################################################
genes <- c(rep(1:length(geneLabs), times = length(sampleNames)))

#########################################################################################
## Create list for data regarding the specific type of variant found in the sample
#########################################################################################
contains <- c(file[,1])
for (b in 2:length(sampleNames)) {
  contains <- c(contains, c(file[ ,b]))
}

#########################################################################################
## Create data frame in long format
#########################################################################################
df <- data.frame(samples, genes, contains)

#########################################################################################
## Optional: Set custom order for samples to be placed on the x-axis (note: sample
## names must have identical spelling as in the sampleNames object)
#########################################################################################
df$samples <- factor(df$samples, levels = c('S159_14_8 ', 'S400_15_7 ', 'S401_15_2 ', 'S189_14_2 ',
                                        'S176_14_2 ', 'S153_14_2 ','S400_15_2 ', 'S416_15_13',
                                        'S160_14_2 ', 'S159_14_2 ', 'S123_14_6 ', 'S412_15_2 ',
                                        'S187_14_1 ', 'S422_15_2 ', 'S416_15_2 ','S189_14_4 ', 
                                        'S132_14_5 ',  'S131_14_9 '))

#########################################################################################
## Create plot. Note that in order to use the switch_axis_position function found in the
## next step, x-axis ticks must be removed by setting their colour to white, as
## axis.ticks.x=element_blank() will cause an error. See:
## https://github.com/wilkelab/cowplot/issues/13
## https://github.com/wilkelab/cowplot/issues/35
#########################################################################################

annotationColors <- matrix(data = c("chartreuse4","lemonchiffon","khaki3","deepskyblue3", "brown4", "deepskyblue3", "deepskyblue3", "chartreuse4", "deepskyblue3", "deepskyblue3", "deepskyblue3", "khaki3", "khaki3", "grey90", "antiquewhite3", "lemonchiffon", "darkgoldenrod4", "darkgoldenrod4"), nrow = 1, ncol = 18)

plotdata <- ggplot(data = df, aes(x = samples, y = rev(genes), fill = contains))
chart <- plotdata + geom_tile() + 
  theme(axis.title.y = element_blank(),
        axis.title.x = element_text(size = 0),
        axis.text.y = element_text(size = 8, face = 'italic', hjust = 1),
        axis.text.x = element_text(size = 8, angle = 270, hjust = -0),
        axis.line = element_blank(),
        panel.background = element_rect(fill = '#ffffff'),
        axis.ticks.y = element_blank(),
        axis.ticks.x = element_line(colour = 'white'),
        plot.margin = unit(c(0, 0.8, 0, 0), "cm")) +
  scale_y_continuous('Genes', breaks = 1:length(geneLabs), labels = rev(geneLabs)) +
  scale_x_discrete(position = "top") +
  annotation_raster(annotationColors, 0.5, 18.5, 61.9, 61) +
  geom_vline(xintercept = seq(1.5, (length(sampleNames) + 0.5), by = 1), color = "white", size = 0.5) +
  geom_hline(yintercept = seq(1.5, (length(geneLabs) + 0.5), by = 1), color = "white", size = 0.5) +
  scale_fill_manual(breaks = levels(df$contains), values = c('chartreuse4', 'midnightblue', 'purple', 'deeppink1','firebrick3', 'coral2'),
                    na.value = 'grey90', name = 'Mutation effect') 

print(chart)


layout <- matrix(c(1,1,1,1,1,1,1,1,
                   1,1,1,1,1,1,1,1,
                   1,1,1,1,1,1,1,1,
                   1,1,1,1,1,1,1,1,
                   1,1,1,1,1,1,1,1,
                   2,2,2,2,2,2,2,0), nrow = 6, byrow = TRUE)

multiplot(chart, VPSplot, cols = 2, layout = layout)
#export as pdf, portrait, width 7.6, height 11
chart + VPSplot + plot_layout(ncol=1, heights = c(4, 1))
