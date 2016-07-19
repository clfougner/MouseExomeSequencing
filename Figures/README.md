####MutationLoadBarChart.r
```
Purpose: Creates a bar chart representing the number of variants per sample.
Input: Number of variants per sample in wide format, as produced my the the output from /Analysis/ModGrepPipeline.sh.
```
Sample output:

![](https://raw.githubusercontent.com/clfougner/MouseExomeSequencing/master/Figures/SampleImages/Screen%20Shot%202016-07-12%20at%2012.17.44.png)

####MutationLoadBarChartTwoHeights.r
```
Purpose: Creates a bar chart with two heights representing the number of variants per sample, in this case one for non-synonymous variants and one for synonymous variants.
Input: Number of variants per sample in wide format, as produced my the the output from /Analysis/ModGrepPipeline.sh, filtered by two parameters (for example synonymous and non-synonymous variants).
```
Sample output:

![](https://raw.githubusercontent.com/clfougner/MouseExomeSequencing/master/Figures/SampleImages/Screen%20Shot%202016-07-12%20at%2012.18.08.png)

####VariantsPlot.r
```
Purpose: Creates a plot giving an overview of the samples in which a given gene has a variant.
Input: Overview of samples containing a given variant in wide format, as produced by the output from /Analysis/CommonGeneList.r
```
Sample output:

![](https://raw.githubusercontent.com/clfougner/MouseExomeSequencing/master/Figures/SampleImages/Screen%20Shot%202016-07-12%20at%2012.10.02.png)

####VariantsPlotSpecific.r
```
Purpose: Creates a plot giving an overview of the samples in which a given gene has a variant and what type of variant is present as, annotated by SnpEff.
Input: Overview of samples containing a given variant, and type of variant, in wide format, as produced by the output from /Analysis/CommonGeneListSpecific.r
```
Sample output:

![](https://raw.githubusercontent.com/clfougner/MouseExomeSequencing/master/Figures/SampleImages/Screen%20Shot%202016-07-12%20at%2012.16.04.png)

####VariantsPlotWithLevels.r
```
Purpose: Creates a plot giving an overview of the samples in which a given gene has a variant and what effect type is caused, as annotated by SnpEff.
Input: Overview of samples containing a given variant, and type of effect caused, in wide format, as produced by the output from /Analysis/CommonGeneListDetails.r
```
Sample output:

![](https://raw.githubusercontent.com/clfougner/MouseExomeSequencing/master/Figures/SampleImages/Screen%20Shot%202016-07-12%20at%2012.17.20.png)

####MutationSpectrumAnalysisSingleNucleotide.r
```
Purpose: Creates a plot displaying the type of single nucleotide substitutions occuring in a list of samples
Input: Text file containing a list of variants, including reference and alternate alleles (output from /VariantCalling/SnpSiftExtract.sh or the files in /Output/SnpSiftExtract/ from /VariantCalling/EntirePipeline.sh). Can be modified to take .vcf files as input using the 'skip' argument in read.table and changing the columns used when creating the data.frames to $V4 (ref) and $V5 (alt).
```
Sample output:

![](https://raw.githubusercontent.com/clfougner/MouseExomeSequencing/master/Figures/SampleImages/SingleNucleotideSubstitutionSpectrum.png)

####DeconstructSigsMouse.r
```
Purpose: Creates a bar chart representing the proportion of single bases substitutions in a trinucleotide context
Input: List of variants as output by /VariantCalling/SnpSiftExtract.sh or the files in /Output/SnpSiftExtract/ from /VariantCalling/EntirePipeline.sh
```

This script uses the [deconstructSigs framework](https://github.com/raerose01/deconstructSigs)[1](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-016-0893-4). As provided, this framework is only intended for use with the hg19 reference genome. In order to use this with the mm10 reference genome, a few changes must be made to the source code. The instructions for this are as follows:

First, in your R console run the following commands:
````
#install.packages('devtools')
#source("https://bioconductor.org/biocLite.R")
#biocLite("BSgenome")
#biocLite("BSgenome.Mmusculus.UCSC.mm10")
```
The "devtools" package is used to install the deconstructSigs from a local folder rather than the central CRAN repository. The other commands download the required reference files.

Second, clone the [deconstructSigs framework](https://github.com/raerose01/deconstructSigs) to your machine. Open the `mut.to.sigs.input.R` file in a text editor and make the following changes:
```
## Line 65:
## From:
  unknown.regions <- levels(mut[, chr])[which(!(levels(mut[, chr]) %in% GenomeInfoDb::seqnames(BSgenome.Hsapiens.UCSC.hg19::Hsapiens)))]
## To:
  unknown.regions <- levels(mut[, chr])[which(!(levels(mut[, chr]) %in% GenomeInfoDb::seqnames(BSgenome.Mmusculus.UCSC.mm10::Mmusculus)))]

## Line 68:
## From:
 warning(paste('Check chr names -- not all match BSgenome.Hsapiens.UCSC.hg19::Hsapiens object:\n', unknown.regions, sep = ' '))
## To:
 warning(paste('Check chr names -- not all match BSgenome.Mmusculus.UCSC.mm10::Mmusculus object:\n', unknown.regions, sep = ' '))

## Line 69:
## From:
  mut <- mut[mut[, chr] %in% GenomeInfoDb::seqnames(BSgenome.Hsapiens.UCSC.h1910::Hsapiens), ]
## To:
   mut <- mut[mut[, chr] %in% GenomeInfoDb::seqnames(BSgenome.Mmusculus.UCSC.mm10::Mmusculus), ]

## Line 74:
## From:
  mut$context = BSgenome::getSeq(BSgenome.Hsapiens.UCSC.hg19::Hsapiens, mut[,chr], mut[,pos]-1, mut[,pos]+1, as.character = T)
## To:
  mut$context = BSgenome::getSeq(BSgenome.Mmusculus.UCSC.mm10::Mmusculus, mut[,chr], mut[,pos]-1, mut[,pos]+1, as.character = T)
```

OPTIONAL step:
I prefer the chart aesthetic found in the original WTSI mutational signature framework[1](http://se.mathworks.com/matlabcentral/fileexchange/38724-wtsi-mutational-signature-framework)[2](http://www.nature.com/nature/journal/v500/n7463/full/nature12477.html)[3](http://www.sciencedirect.com/science/article/pii/S0092867412005284) to that found in the [deconstructSigs framework](https://raw.githubusercontent.com/raerose01/deconstructSigs/master/inst/extdata/plotSignatures.png) and have therefore made a few changes to the `plotting.R` file in order to arrive at the figure shown below:

```
## Change colour of horizontal background lines
## Lines 76 and 83
## From:
   graphics::abline(h = seq(from = 0, to = y_limit, by = 0.01), col = '#d3d3d350', lty = 1)
## To:
  graphics::abline(h = seq(from = 0, to = y_limit, by = 0.01), col = 'darkgrey', lty = 1)

## Line 90
## From
 graphics::abline(h = seq(from = -y_limit, to = y_limit, by = 0.1), col = '#d3d3d350', lty = 1)
## To
 graphics::abline(h = seq(from = -y_limit, to = y_limit, by = 0.1), col = 'darkgrey', lty = 1)
 
## Remove vertical lines from plot
Comment out/remove lines 77, 84 and 91

## Change color pallete for barplot (Line 70) and legend (line 96)
##Line 70
##From:
  grDevices::palette(c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2"))
##To:
  grDevices::palette(c("deepskyblue", "black", "red", "magenta4", "forestgreen", "salmon"))

##Line 96
##From:
  graphics::legend('right', legend = unique(tumor_plotting$mutation), col = c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2"), bty = 'n', ncol = 1, inset=c(-0,0), pch = 15, xpd = TRUE, pt.cex = 2.5)
##To:
  graphics::legend('right', legend = unique(tumor_plotting$mutation), col = c("deepskyblue", "black", "red", "magenta4", "forestgreen", "salmon"), bty = 'n', ncol = 1, inset=c(-0,0), pch = 15, xpd = TRUE, pt.cex = 2.5)

## Remove axis ticks
## Lines 78 and 85
## From:
  graphics::barplot(tumor_plotting$fraction, names.arg = tumor_plotting$full_context, cex.names = 0.7, las = 2, col = factor(tumor_plotting$mutation), ylim = c(0, y_limit), border = NA, space = 0.3, main = top.title, ylab = 'fraction', add = TRUE)
## To:
   graphics::barplot(tumor_plotting$fraction, names.arg = tumor_plotting$full_context, cex.names = 0.7, las = 2, col = factor(tumor_plotting$mutation), ylim = c(0, y_limit), border = NA, space = 0.3, main = top.title, ylab = 'fraction', add = TRUE, col.ticks=rgb(0,0,0,0))

## Line 92:
## From:
  graphics::barplot(diff_plotting$fraction, names.arg = diff_plotting$full_context, cex.names = 0.7, las = 2, col = factor(diff_plotting$mutation), ylim = c(-y_limit, y_limit), border = 'black', space = 0.3, main = paste("error = ", error_summed, sep = ""), ylab = 'fraction', add = TRUE)
## To:
  graphics::barplot(diff_plotting$fraction, names.arg = diff_plotting$full_context, cex.names = 0.7, las = 2, col = factor(diff_plotting$mutation), ylim = c(-y_limit, y_limit), border = 'black', space = 0.3, main = paste("error = ", error_summed, sep = ""), ylab = 'fraction', add = TRUE, col.ticks=rgb(0,0,0,0))
```

Finally, go back to your R console and install the package:
```
library(devtools)
install('/path/to/deconstructSigs-master')
library(deconstructSigs)
```

The script can now be run using your own files. Remember, this is only required for data from mouse samples. If you've used the mm9 reference genome to align your sequence data, remember to make the necessary adjustments.

Sample output:

![](https://raw.githubusercontent.com/clfougner/MouseExomeSequencing/master/Figures/SampleImages/Screen%20Shot%202016-07-12%20at%2012.17.44.png)
