library('ggplot2')
#library('cowplot')

#########################################################################################
## Read file for CommonGeneListDetails.r -> FilterForVogelstein.r
#########################################################################################
file<-read.table(file="/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/AnalysisResults_w20k/Analysis/CollatedAmpDelList_w20k_COSMIC.txt", stringsAsFactors=FALSE)

#########################################################################################
## Sample names in same order as input file
#########################################################################################
sampleNames<-c('S123_14_6', 'S131_14_9', 'S132_14_5', 'S153_14_2',
               'S159_14_2', 'S159_14_8', 'S160_14_2', 'S176_14_2',
               'S187_14_1', 'S189_14_2', 'S189_14_4', 'S400_15_2',
               'S400_15_7', 'S401_15_2', 'S412_15_2', 'S416_15_2',
               'S416_15_13', 'S422_15_2')

#########################################################################################
## Create data frame of input file
#########################################################################################
df<-data.frame(file)

#########################################################################################
## Create list of gene names (row names in input file)
#########################################################################################
geneLabs<-row.names(df)

#########################################################################################
## Create list of sample names in the form of: sample1(repeat*number of genes), sample2(
## repeat*number of genes)... sampleN(repeat*number of genes) Required for making data in
## long format
#########################################################################################
samples<-c(rep(sampleNames[1], times=length(geneLabs)))
for (a in 2:length(sampleNames)) {
 samples<-c(samples, c(rep(sampleNames[a], times=length(geneLabs)))) 
 }

#########################################################################################
## Create list of genes in the form of: (gene1, gene2, gene3... geneN)(repeat*number of 
## samples) .Required for making data in long format
#########################################################################################
genes<-c(rep(1:length(geneLabs), times=length(sampleNames)))

#########################################################################################
## Create list for data regarding variant effect (HIGH, MODERATE, LOW or NA)
#########################################################################################
contains<-c(file[,1])
for (b in 2:length(sampleNames)){
  contains<-c(contains, c(file[ ,b]))
}

#########################################################################################
## Create data frame in long format
#########################################################################################
df<-data.frame(samples, genes, contains)

#########################################################################################
## Optional: Set custom order for samples to be placed on the x-axis (note: sample
## names must have identical spelling as in the sampleNames object), and order of effect
## type in the legend
#########################################################################################
df$contains<-factor(df$contains, levels=c('amp',"del"))
df$samples<-factor(df$samples, levels=c('S159_14_2', 'S159_14_8',  'S176_14_2','S412_15_2','S400_15_7', 'S400_15_2', 'S422_15_2', 'S132_14_5', 'S401_15_2', 'S187_14_1', 'S160_14_2', 'S123_14_6', 'S416_15_2','S189_14_4','S416_15_13', 'S153_14_2', 'S189_14_2', 'S131_14_9'))

#Annotation colors
annotationColorsSubtype<-c()
annotationColorsCluster<-c()

tumors<-read.table(file="/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/MouseSubtypes.txt", header=FALSE, sep="\t")
colnames(tumors) <- c("sampleName", "subtype", "cluster")

for (i in 1:length(levels(df$samples))){
  lineNum<-grep(x=tumors$sampleName, pattern=levels(df$samples)[i])
  
  if (is.na(tumors[lineNum, "cluster"])){
    annotationColorsSubtype<-c(annotationColorsSubtype, "grey90")
    annotationColorsCluster<-c(annotationColorsCluster, "grey90")
    next
  }
  
  if(tumors[lineNum, "cluster"] =="CL"){
    annotationColorsCluster<-c(annotationColorsCluster, "goldenrod3")
    
    if(tumors[lineNum, "subtype"] == "Claudin-lowEx"){
      annotationColorsSubtype<-c(annotationColorsSubtype, "deepskyblue3")
    }
    
    if(tumors[lineNum, "subtype"] == "Squamous-likeEx"){
      annotationColorsSubtype<-c(annotationColorsSubtype, "darkgoldenrod4")
    }
  }
  
  if(tumors[lineNum, "cluster"] =="Other"){
    annotationColorsCluster<-c(annotationColorsCluster, "dodgerblue4")
    
    if(tumors[lineNum, "subtype"] == "Class8Ex"){
      annotationColorsSubtype<-c(annotationColorsSubtype, "chartreuse4")
    }
    
    if(tumors[lineNum, "subtype"] == "Erbb2-likeEx"){
      annotationColorsSubtype<-c(annotationColorsSubtype, "antiquewhite3")
    }
    
    if(tumors[lineNum, "subtype"] == "PyMTEx"){
      annotationColorsSubtype<-c(annotationColorsSubtype, "khaki3")
    }
    
    if(tumors[lineNum, "subtype"] == "Class3Ex"){
      annotationColorsSubtype<-c(annotationColorsSubtype, "brown4")
    }
    
    if(tumors[lineNum, "subtype"] == "Class14Ex"){
      annotationColorsSubtype<-c(annotationColorsSubtype, "lemonchiffon")
    }
  }
}
annotationColorsSubtype <- matrix(data = annotationColorsSubtype, nrow = 1, ncol = length(annotationColorsSubtype))
annotationColorsCluster <- matrix(data = annotationColorsCluster, nrow = 1, ncol = length(annotationColorsCluster))

plotdata<-ggplot(data=df, aes(x=samples, y=rev(genes), fill=contains))
chart<-plotdata+geom_raster() + 
    theme(axis.title.y=element_blank(),
          axis.title.x=element_text(size=0),
          axis.text.y=element_text(size=10, face='italic', hjust=1),
          axis.text.x=element_text(size=14, face='bold', angle=270),
          axis.line=element_blank(),
          panel.background=element_rect(fill='#ffffff'),
          axis.ticks.y=element_blank(),
          axis.ticks.x=element_line(colour='white')) +
    scale_y_continuous('Genes', breaks=1:length(geneLabs), labels=rev(geneLabs)) +
    scale_x_discrete(position = "top") +
    geom_vline(xintercept = seq(1.5, (length(sampleNames)+0.5), by=1), color = "white", size = 0.5) +
    geom_hline(yintercept = seq(1.5, (length(geneLabs)+0.5), by=1), color = "white", size = 0.5) +
    scale_fill_manual(values=c('red', "blue"), labels=c("Amplification", "Deletion", "NA"), na.value='grey85', name='CNA') +
  annotation_raster(annotationColorsSubtype, 0.5, 18.5, 49, 49.9) +
  annotation_raster(annotationColorsCluster, 0.5, 18.5, 50, 50.9)
  
print(chart)
#ggsave("/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/AnalysisResults_w50k/DMBAAmpDels.png", chart, width = 8, height = 13, dpi = 300)

