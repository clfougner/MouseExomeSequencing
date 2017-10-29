library(ComplexHeatmap)

CNA<-read.table(file='/Users/christianfougner/Documents/Forskerlinja/DMBA-indusert/Sequencing/Output/AnalysisResults_w50k/CollatedAmpDelList-3.txt')

colors<-c("Claudin-lowEx" ="deepskyblue3","Squamous-likeEx" = "darkgoldenrod4", "Class8Ex"= "chartreuse4", "Erbb2-likeEx" ="antiquewhite3", "PyMTEx" = "khaki3", "Class3Ex" = "brown4", "Class14Ex"= "lemonchiffon", "NA"="grey")

df <- data.frame(Subtype = c("Claudin-lowEx", "Squamous-likeEx", "Squamous-likeEx", "Claudin-lowEx", "Claudin-lowEx", "Class8Ex", "Claudin-lowEx", "Class3Ex", "PyMTEx", "Claudin-lowEx", "Class14Ex", "Claudin-lowEx", "Class14Ex", "PyMTEx", "PyMTEx", "Class8Ex", "Erbb2-likeEx", "NA"))

colors2<-c("CL"="goldenrod3", "Other"="dodgerblue4", "NA"="grey")
df2<-data.frame(Cluster=c("CL", "CL", "CL", "CL", "CL", "Other", "CL", "Other", "Other", "CL", "Other", "CL", "Other", "Other", "Other", "Other", "Other", "NA"))

df3<-data.frame(df2, df)

ha = HeatmapAnnotation(df = df3, col = list(Subtype = colors, Cluster=colors2 ))

Heatmap(as.matrix(CNA), top_annotation = ha, show_row_names = FALSE)