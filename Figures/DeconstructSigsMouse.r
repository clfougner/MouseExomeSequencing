#install.packages('devtools')
library(devtools)
#source("https://bioconductor.org/biocLite.R")
#biocLite("BSgenome")
#biocLite("BSgenome.Mmusculus.UCSC.mm10")


#Clone package from GitHub: https://github.com/raerose01/deconstructSigs

#Edit:
#mut.to.sigs.input.R
# line65:
#From:
# unknown.regions <- levels(mut[, chr])[which(!(levels(mut[, chr]) %in% GenomeInfoDb::seqnames(BSgenome.Hsapiens.UCSC.hg19::Hsapiens)))]
#To:
# unknown.regions <- levels(mut[, chr])[which(!(levels(mut[, chr]) %in% GenomeInfoDb::seqnames(BSgenome.Mmusculus.UCSC.mm10::Mmusculus)))]

# line68:
#From:
#  warning(paste('Check chr names -- not all match BSgenome.Hsapiens.UCSC.hg19::Hsapiens object:\n', unknown.regions, sep = ' '))
#To:
#  warning(paste('Check chr names -- not all match BSgenome.Mmusculus.UCSC.mm10::Mmusculus object:\n', unknown.regions, sep = ' '))

# line69:
#From:
#   mut <- mut[mut[, chr] %in% GenomeInfoDb::seqnames(BSgenome.Hsapiens.UCSC.h1910::Hsapiens), ]
#To:
#    mut <- mut[mut[, chr] %in% GenomeInfoDb::seqnames(BSgenome.Mmusculus.UCSC.mm10::Mmusculus), ]

# line74:
#From:
#  mut$context = BSgenome::getSeq(BSgenome.Hsapiens.UCSC.hg19::Hsapiens, mut[,chr], mut[,pos]-1, mut[,pos]+1, as.character = T)
#To:
#    mut$context = BSgenome::getSeq(BSgenome.Mmusculus.UCSC.mm10::Mmusculus, mut[,chr], mut[,pos]-1, mut[,pos]+1, as.character = T)

#changes to plotting.r

# Modify horizontal lines from plot
# Lines 76, 83 and 90
# From:
#    graphics::abline(h = seq(from = 0, to = y_limit, by = 0.01), col = '#d3d3d350, lty = 1)
# To:
#   graphics::abline(h = seq(from = 0, to = y_limit, by = 0.01), col = 'darkgrey', lty = 1)


# Remove vertical lines from plot
#Comment out lines 77, 84 and 91

# Change color pallete for barplot (Line 70) and legend (line 96)
# Line 70
# From:
#   grDevices::palette(c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2"))
# To:
#   grDevices::palette(c("deepskyblue", "black", "red", "magenta4", "forestgreen", "salmon"))

# Line 96
# From:
#   graphics::legend('right', legend = unique(tumor_plotting$mutation), col = c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2"), bty = 'n', ncol = 1, inset=c(-0,0), pch = 15, xpd = TRUE, pt.cex = 2.5)
# To:
#   graphics::legend('right', legend = unique(tumor_plotting$mutation), col = c("deepskyblue", "black", "red", "magenta4", "forestgreen", "salmon"), bty = 'n', ncol = 1, inset=c(-0,0), pch = 15, xpd = TRUE, pt.cex = 2.5)

# Remove axis ticks
# Lines 78, 85
# From:
#   graphics::barplot(tumor_plotting$fraction, names.arg = tumor_plotting$full_context, cex.names = 0.7, las = 2, col = factor(tumor_plotting$mutation), ylim = c(0, y_limit), border = NA, space = 0.3, main = top.title, ylab = 'fraction', add = TRUE)
# To:
#    graphics::barplot(tumor_plotting$fraction, names.arg = tumor_plotting$full_context, cex.names = 0.7, las = 2, col = factor(tumor_plotting$mutation), ylim = c(0, y_limit), border = NA, space = 0.3, main = top.title, ylab = 'fraction', add = TRUE, col.ticks=rgb(0,0,0,0))

#Line 92:
# From:
#   graphics::barplot(diff_plotting$fraction, names.arg = diff_plotting$full_context, cex.names = 0.7, las = 2, col = factor(diff_plotting$mutation), ylim = c(-y_limit, y_limit), border = 'black', space = 0.3, main = paste("error = ", error_summed, sep = ""), ylab = 'fraction', add = TRUE)
# To:
#   graphics::barplot(diff_plotting$fraction, names.arg = diff_plotting$full_context, cex.names = 0.7, las = 2, col = factor(diff_plotting$mutation), ylim = c(-y_limit, y_limit), border = 'black', space = 0.3, main = paste("error = ", error_summed, sep = ""), ylab = 'fraction', add = TRUE, col.ticks=rgb(0,0,0,0))



#install('/path/to/deconstructSigs-master)
library(deconstructSigs)

S123_14_6_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RF/UniqueCoordinates/123_14_6.AD10AF005FR.annotated.passfiltered.extracted.dedup.txt", sep='\t')
S131_14_9_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RF/UniqueCoordinates/131_14_9.AD10AF005FR.annotated.passfiltered.extracted.dedup.txt", sep='\t')
S132_14_5_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RF/UniqueCoordinates/132_14_5.AD10AF005FR.annotated.passfiltered.extracted.dedup.txt", sep='\t')
S153_14_2_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RF/UniqueCoordinates/153_14_2.AD10AF005FR.annotated.passfiltered.extracted.dedup.txt", sep='\t')
S159_14_2_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RF/UniqueCoordinates/159_14_2.AD10AF005FR.annotated.passfiltered.extracted.dedup.txt", sep='\t')
S159_14_8_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RF/UniqueCoordinates/159_14_8.AD10AF005FR.annotated.passfiltered.extracted.dedup.txt", sep='\t')
S160_14_2_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RF/UniqueCoordinates/160_14_2.AD10AF005FR.annotated.passfiltered.extracted.dedup.txt", sep='\t')
S176_14_2_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RF/UniqueCoordinates/176_14_2.AD10AF005FR.annotated.passfiltered.extracted.dedup.txt", sep='\t')
S187_14_1_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RF/UniqueCoordinates/187_14_1.AD10AF005FR.annotated.passfiltered.extracted.dedup.txt", sep='\t')
S189_14_2_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RF/UniqueCoordinates/189_14_2.AD10AF005FR.annotated.passfiltered.extracted.dedup.txt", sep='\t')
S189_14_4_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RF/UniqueCoordinates/189_14_4.AD10AF005FR.annotated.passfiltered.extracted.dedup.txt", sep='\t')
S400_15_2_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RF/UniqueCoordinates/400_15_2.AD10AF005FR.annotated.passfiltered.extracted.dedup.txt", sep='\t')
S400_15_7_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RF/UniqueCoordinates/400_15_7.AD10AF005FR.annotated.passfiltered.extracted.dedup.txt", sep='\t')
S401_15_2_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RF/UniqueCoordinates/401_15_2.AD10AF005FR.annotated.passfiltered.extracted.dedup.txt", sep='\t')
S412_15_2_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RF/UniqueCoordinates/412_15_2.AD10AF005FR.annotated.passfiltered.extracted.dedup.txt", sep='\t')
S416_15_13_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RF/UniqueCoordinates/415_15_13.AD10AF005FR.annotated.passfiltered.extracted.dedup.txt", sep='\t')
S416_15_2_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RF/UniqueCoordinates/416_15_2.AD10AF005FR.annotated.passfiltered.extracted.dedup.txt", sep='\t')
S422_15_2_table<-read.table("/Volumes/christian/DMBA-induced/Output/FilterTests/OnePerLineAD10AF005RF/UniqueCoordinates/422_15_2.AD10AF005FR.annotated.passfiltered.extracted.dedup.txt", sep='\t')

df1<-data.frame(sample=c(rep('S123_14_6', times=(length(S123_14_6_table$V3)))), chr=S123_14_6_table$V1, pos=S123_14_6_table$V2, ref=S123_14_6_table$V3, alt=S123_14_6_table$V4)
df2<-data.frame(sample=c(rep('S131_14_9', times=(length(S131_14_9_table$V3)))), chr=S131_14_9_table$V1, pos=S131_14_9_table$V2, ref=S131_14_9_table$V3, alt=S131_14_9_table$V4)
df3<-data.frame(sample=c(rep('S132_14_5', times=(length(S132_14_5_table$V3)))), chr=S132_14_5_table$V1, pos=S132_14_5_table$V2, ref=S132_14_5_table$V3, alt=S132_14_5_table$V4)
df4<-data.frame(sample=c(rep('S153_14_2', times=(length(S153_14_2_table$V3)))), chr=S153_14_2_table$V1, pos=S153_14_2_table$V2, ref=S153_14_2_table$V3, alt=S153_14_2_table$V4)
df5<-data.frame(sample=c(rep('S159_14_2', times=(length(S159_14_2_table$V3)))), chr=S159_14_2_table$V1, pos=S159_14_2_table$V2, ref=S159_14_2_table$V3, alt=S159_14_2_table$V4)
df6<-data.frame(sample=c(rep('S159_14_8', times=(length(S159_14_8_table$V3)))), chr=S159_14_8_table$V1, pos=S159_14_8_table$V2, ref=S159_14_8_table$V3, alt=S159_14_8_table$V4)
df7<-data.frame(sample=c(rep('S160_14_2', times=(length(S160_14_2_table$V3)))), chr=S160_14_2_table$V1, pos=S160_14_2_table$V2, ref=S160_14_2_table$V3, alt=S160_14_2_table$V4)
df8<-data.frame(sample=c(rep('S176_14_2', times=(length(S176_14_2_table$V3)))), chr=S176_14_2_table$V1, pos=S176_14_2_table$V2, ref=S176_14_2_table$V3, alt=S176_14_2_table$V4)
df9<-data.frame(sample=c(rep('S187_14_1', times=(length(S187_14_1_table$V3)))), chr=S187_14_1_table$V1, pos=S187_14_1_table$V2, ref=S187_14_1_table$V3, alt=S187_14_1_table$V4)
df10<-data.frame(sample=c(rep('S189_14_2', times=(length(S189_14_2_table$V3)))), chr=S189_14_2_table$V1, pos=S189_14_2_table$V2, ref=S189_14_2_table$V3, alt=S189_14_2_table$V4)
df11<-data.frame(sample=c(rep('S189_14_4', times=(length(S189_14_4_table$V3)))), chr=S189_14_4_table$V1, pos=S189_14_4_table$V2, ref=S189_14_4_table$V3, alt=S189_14_4_table$V4)
df12<-data.frame(sample=c(rep('S400_15_2', times=(length(S400_15_2_table$V3)))), chr=S400_15_2_table$V1, pos=S400_15_2_table$V2, ref=S400_15_2_table$V3, alt=S400_15_2_table$V4)
df13<-data.frame(sample=c(rep('S400_15_7', times=(length(S400_15_7_table$V3)))), chr=S400_15_7_table$V1, pos=S400_15_7_table$V2, ref=S400_15_7_table$V3, alt=S400_15_7_table$V4)
df14<-data.frame(sample=c(rep('S401_15_2', times=(length(S401_15_2_table$V3)))), chr=S401_15_2_table$V1, pos=S401_15_2_table$V2, ref=S401_15_2_table$V3, alt=S401_15_2_table$V4)
df15<-data.frame(sample=c(rep('S412_15_2', times=(length(S412_15_2_table$V3)))), chr=S412_15_2_table$V1, pos=S412_15_2_table$V2, ref=S412_15_2_table$V3, alt=S412_15_2_table$V4)
df16<-data.frame(sample=c(rep('S416_15_13', times=(length(S416_15_13_table$V3)))), chr=S416_15_13_table$V1, pos=S416_15_13_table$V2, ref=S416_15_13_table$V3, alt=S416_15_13_table$V4)
df17<-data.frame(sample=c(rep('S416_15_2', times=(length(S416_15_2_table$V3)))), chr=S416_15_2_table$V1, pos=S416_15_2_table$V2, ref=S416_15_2_table$V3, alt=S416_15_2_table$V4)
df18<-data.frame(sample=c(rep('S422_15_2', times=(length(S422_15_2_table$V3)))), chr=S422_15_2_table$V1, pos=S422_15_2_table$V2, ref=S422_15_2_table$V3, alt=S422_15_2_table$V4)

alldfs<-rbind(df1, df2, df3, df4, df5, df6, df7, df8, df9, df10,
             df11, df12, df13, df14, df15, df16, df17, df18)
  
sigs.input <- mut.to.sigs.input(mut.ref = alldfs, 
                                sample.id = "sample", 
                                chr = "chr", 
                                pos = "pos", 
                                ref = "ref", 
                                alt = "alt")

wchSig = whichSignatures(tumor.ref = sigs.input, 
                         signatures.ref = signatures.nature2013, 
                         sample.id = 'S123_14_6', 
                         contexts.needed = TRUE,
                         tri.counts.method = 'default')



chart<-plotSignatures(wchSig)


