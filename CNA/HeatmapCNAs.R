library(ComplexHeatmap)

CNA<-read.table(file='/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/AnalysisResults_w20k/Analysis/CollatedAmpDelList_w20k_call.txt', sep="\t", na=NA, header=TRUE)
CNA <- CNA[, 1:18]
for(i in 1:length(CNA)){
  for (n in 1:length(CNA$S123_14_6)){
    if (is.na(CNA[n,i])){
      CNA[n,i] <- 0
    }
  }
}

#################################

##############################
#Annotate by subtype/cluster
##############################
colorsSubtype<-c("Claudin-lowEx" ="deepskyblue3","Squamous-likeEx" = "darkgoldenrod4", "Class8Ex"= "chartreuse4", "Erbb2-likeEx" ="antiquewhite3", "PyMTEx" = "khaki3", "Class3Ex" = "brown4", "Class14Ex"= "lemonchiffon", "NA"="grey")
subtypesDF <- data.frame(Subtype = c("Claudin-lowEx", "Squamous-likeEx", "Squamous-likeEx", "Claudin-lowEx", "Claudin-lowEx", "Class8Ex", "Claudin-lowEx", "Class3Ex", "PyMTEx", "Claudin-lowEx", "Class14Ex", "Claudin-lowEx", "Class14Ex", "PyMTEx", "PyMTEx", "Class8Ex", "Erbb2-likeEx", "NA"))
colorsCluster<-c("CL"="goldenrod3", "Other"="dodgerblue4", "NA"="grey")
clusterDF<-data.frame(Cluster=c("CL", "CL", "CL", "CL", "CL", "Other", "CL", "Other", "Other", "CL", "Other", "CL", "Other", "Other", "Other", "Other", "Other", "NA"))

#############################################
# Get data for mutation frequency annotation
#############################################
filteredvars <- read.table(file = '/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/FilteringOwnDataTests.txt', header = TRUE, sep = '\t', stringsAsFactors = F)
mutFreqDF <- data.frame(filteredvars, stringsAsFactors = FALSE, row.names = filteredvars$Filter)
mutFreqDF <- mutFreqDF[ , !(names(mutFreqDF) %in% 'Filter')]
mutFreqDF <- mutFreqDF['mm10, Mutect, AD>10, AF>0.05, RF, modifier removed',]
mutFreqDF <- t(mutFreqDF)
row.names(mutFreqDF) <- sampleNames
colnames(mutFreqDF) <-"MutationFrequency"

##################################
# Get CNA burden values
##################################

# Chromosome lengths
chromLengths<-read.table(file="/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/mm10chromlengths.txt", header=FALSE, sep="\t")
chromLengths<-data.frame(chromLengths, aggregate=rep(NA, time=length(chromLengths$V1)))

totalLength <- sum(as.numeric(chromLengths$V2))

tumors<-read.table(file="/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/MouseSubtypes.txt", header=FALSE, sep="\t")
colnames(tumors) <- c("sampleName", "subtype", "cluster")

findProportion <- function(file){
  fastCallResults<-read.table(file = filePath, header=TRUE, sep="\t")
  nBases <- c()
  for (n in 1:length(fastCallResults$Chromosome)){
    significant <- as.numeric(fastCallResults[n, "ProbCall"]) > 0.95
    if (significant){
      start <- fastCallResults[n, "Start"]
      end <- fastCallResults[n, "End"]
      segLength <- end - start
      nBases <- c(nBases, segLength)
    }
  }
  ampDelBases <- sum(nBases)
  prop <- ampDelBases/totalLength
  return(prop)
}

allProportions <- c()
for (sample in 1:length(tumors$sampleName)){
  filePath<-paste("/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/AnalysisResults_w20k/Results/", tumors$sampleName[sample], "/FastCallResults_", tumors$sampleName[sample], ".txt", sep="")
  proportion <- findProportion(file = filePath)
  allProportions <- c(allProportions, proportion)
}

tumors <- cbind(tumors, CNA_proportion = allProportions)
cnaFreqDF <- data.frame(CNA_proportion = tumors[, "CNA_proportion"], row.names = tumors[, "sampleName"])


# Collate top annotations
annotationDF<-data.frame(clusterDF, subtypesDF, mutFreqDF, cnaFreqDF)

ha = HeatmapAnnotation(df = annotationDF, col = list(Subtype = colorsSubtype, Cluster=colorsCluster, MutationFrequency = colorRamp2(c(0, max(mutFreqDF[,1])), c("gray98", "turquoise4")), CNA_proportion = colorRamp2(c(0, max(cnaFreqDF[,1])), c("gray98", "red"))), gap = unit(0.5, "mm"))


# Make plot with ComplexHeatMap

#pdf(file="/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/test/CNAclusterplotw20k.pdf")
Plot<-Heatmap(as.matrix(CNA),
              show_row_names = FALSE,
              #cluster_rows = FALSE,
              top_annotation = ha,
              column_names_side = c("bottom"),
              heatmap_legend_param = list(title = "CNA", color_bar = "continuous"),
              column_title_rot = 90,
              combined_name_fun = NULL)
print(Plot)

#dev.off()

