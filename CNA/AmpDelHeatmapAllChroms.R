library(ComplexHeatmap)
library(circlize)

startTime <- Sys.time()

# Chromosome lengths
chromLengths<-read.table(file="/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/ReferenceFiles/mm10chromlengths.txt", header=FALSE, sep="\t")
chromLengths<-data.frame(chromLengths, aggregate=rep(NA, times=length(chromLengths$V1)))
for (i in 1:length(chromLengths$V1)){ 
  chromLengths[i, "aggregate"]<-sum(as.numeric(chromLengths[(1:i), 2]))
}

sampleNames<-c('S123_14_6', 'S131_14_9', 'S132_14_5', 'S153_14_2',
               'S159_14_2', 'S159_14_8', 'S160_14_2', 'S176_14_2',
               'S187_14_1', 'S189_14_2', 'S189_14_4', 'S400_15_2',
               'S400_15_7', 'S401_15_2', 'S412_15_2', 'S416_15_2',
               'S416_15_13', 'S422_15_2')

Duplicates <- 0
binSize<-500000
allDF<-data.frame(bin=(seq(from=0, to=chromLengths[20,"aggregate"], by=binSize)))

for(SN in sampleNames){
  filepath<-paste("/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/AnalysisResults_w20k/Results/", SN, "/FastCallResults_", SN, ".txt", sep="")
  
  # Import table of CNAs
  CNATable<-read.table(file=filepath, sep="\t", header=TRUE)
  
  # Filter out CNAs with a probability call under 0.95
  all<-c()
  for (i in 1:length(CNATable$Chromosome)){
    if (CNATable[i, "ProbCall"] > 0.00){
      all<-c(all, i)
    }
  }
  CNATable<-CNATable[all, ]
  
  # Reset row numbers
  rownames(CNATable) <- seq(length=nrow(CNATable))
  
  # Find "aggregate" chromosome positions
  CNATable<-data.frame(CNATable, aggStart=rep(NA), aggEnd=(NA))
  
  for(i in 1:length(CNATable$Chromosome)){
    queryLine<-grep(pattern=paste("^", CNATable[i, "Chromosome"], "$", sep=""), x=chromLengths$V1)
    
    if (length(queryLine) == 0){
      print("Grep failed")
    }
    
    if(queryLine == 1){
      CNATable[i, "aggStart"]<-CNATable[i, "Start"]
      CNATable[i, "aggEnd"]<-CNATable[i, "End"]
    }
    
    if(queryLine > 1){
      CNATable[i, "aggStart"]<-CNATable[i, "Start"] + chromLengths[(queryLine-1), "aggregate"]
      CNATable[i, "aggEnd"]<-CNATable[i, "End"] + chromLengths[(queryLine-1), "aggregate"]
    }
  }
  
  # Create data frame with bins along the entire chromosome
  CNATable_bins<-data.frame(bin=(seq(from=0, to=chromLengths[20,"aggregate"], by=binSize)), CNA=rep(0))
  
  for(n in 1:length(CNATable$Chromosome)){
    for (i in 1:(length(CNATable_bins$bin))){
      
      if(is.na(CNATable_bins[(i+1), "bin"])){
        next
      } 
      
      chromPosition_lowerBound<-CNATable_bins[i, "bin"]
      chromPosition_upperBound<-CNATable_bins[(i+1), "bin"]
      
      CNAPosition_lowerBound<-CNATable[n, "aggStart"]
      CNAPosition_upperBound<-CNATable[n, "aggEnd"]
      
      overlap <- (max(chromPosition_lowerBound,CNAPosition_lowerBound)<=min(chromPosition_upperBound,CNAPosition_upperBound))
      
      if(overlap==TRUE){
        if (CNATable_bins[i, "CNA"] > 0){
          currentCall<-CNATable[n, "Call"]
          oldCall <- CNATable_bins[i, "CNA"]
          print(paste("Old value is: ", currentCall, ". New value is: ", oldCall))
          Duplicates <- Duplicates + 1
        }
        CNATable_bins[i,"CNA"]<-CNATable[n, "Call"]
      }
    }
  }
  allDF<-cbind(allDF, CNATable_bins$CNA)
}

# Reformat the data frame
allDF<-data.frame(allDF[2:length(allDF)], row.names = CNATable_bins$bin)
colnames(allDF)<-sampleNames

# Separate heatmap by chromosome
rowSeps<-c(ceiling(chromLengths$aggregate/binSize))
allSplits<-c()
for(i in 1:length(chromLengths$V1)){
  
  if(i == 1){
    current<-rep(letters[i], times=rowSeps[i])
  }
  
  if(i > 1){
    nTimes<-rowSeps[i]-rowSeps[i-1]
    current<-rep(letters[i], times=nTimes)
  }
  
  allSplits<-c(allSplits, current)
}

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
    significant <- as.numeric(fastCallResults[n, "ProbCall"]) > 0.00
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


# Side annotation
colorsChroms<-c("chr1"="lightblue1", "chr2"="lightblue3","chr3"="lightblue1", "chr4"="lightblue3","chr5"="lightblue1", "chr6"="lightblue3","chr7"="lightblue1", "chr8"="lightblue3","chr9"="lightblue1", "chr10"="lightblue3","chr11"="lightblue1", "chr12"="lightblue3","chr13"="lightblue1", "chr14"="lightblue3","chr15"="lightblue1", "chr16"="lightblue3","chr17"="lightblue1", "chr18"="lightblue3","chr19"="lightblue1", "chrX"="lightblue3")

rowChroms<-c()
for (i in 1:length(rowSeps)){
  
  if (i == 1){
    chr<-paste("chr", i, sep="")
    current<-rep(chr, times=rowSeps[i]) 
  }
  
  if (i > 1){
    
    if (i == 20){
      chr<-"chrX"
      nReps<-rowSeps[i] - rowSeps[i-1]
      current<-rep(chr, times=nReps) 
    }
    
    if (i < 20){
      chr<-paste("chr", i, sep="")
      nReps<-rowSeps[i] - rowSeps[i-1]
      current<-rep(chr, times=nReps)
    }
  }
  
  rowChroms<-c(rowChroms, current)
}

rowChroms<-data.frame(chrom=rowChroms, row.names = CNATable_bins$bin)
sideHA <- HeatmapAnnotation(df = rowChroms, col= list(chrom = colorsChroms), which="row", show_legend=FALSE, annotation_width = 0.5, gap = unit(0, "mm"))

# Make plot with ComplexHeatMap

pdf(file="/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/test/CNAclusterplotw20k.pdf")
Plot<-Heatmap(as.matrix(allDF),
              cluster_rows = FALSE,
              show_row_names = FALSE,
              top_annotation = ha,
              column_names_side = c("bottom"),
              heatmap_legend_param = list(title = "CNA", color_bar = "continuous"),
              column_title_rot = 90,
              split = allSplits,
              gap = unit(0.5, "mm"),
              combined_name_fun = NULL)

add_heatmap(Plot, sideHA)
print(Plot)

dev.off()

endTime <- Sys.time()

print(endTime - startTime)
print(Duplicates)


