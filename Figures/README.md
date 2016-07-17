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
