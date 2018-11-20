# Mouse Exome Sequencing Analysis

This is a repository to document my work in setting up a pipeline for somatic variant calling from mouse exome sequencing data, and downstream analyis thereof . It is for my own research use, but may act as a guideline for anyone looking to do accomplish the same goal.

This repository is organized as follows:
````
Install           Instructions on installing the necessary frameworks
ReferenceFiles    Instructions on downloading and processing th enecessary reference files
VariantCalling    Pipeline for variant calling (including preprocessing and annotation)
PostProcessing    Scripts used for downstream analysis of called variants
Figures           Scripts used for creating figures
`````

The information/scripts found in Install, ReferenceFiles and VariantCalling should be applicable to anyone working with variant calling from sequencing data; scripts found in PostProcessing and Figures may be of less general interest.

The exome sequencing data used for this project was generated at the TheragenEtex Institute in South Korea, using an Illumina HiSeq and the Agilent SureSelect Mouse All Exon Kit. The tissue used was collected from FVB/N mice, which is reflected in the choice of SNP and indel files.
