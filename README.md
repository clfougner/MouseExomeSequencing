# Mouse Exome Sequencing Analysis

This repository documents a pipeline for somatic variant calling from mouse exome sequence data. It is for my own research use, but may act as a guideline for anyone looking to do accomplish the same goal. The pipeline is based on the [Broad Institute's best practices](https://www.broadinstitute.org/gatk/guide/best-practices.php).

This repository is organized as follows:
````
Install           Instructions on installing the necessary frameworks
ReferenceFiles    Instructions on downloading and processing the necessary reference files
VariantCalling    Pipeline for variant calling (including preprocessing and annotation)
`````

The exome sequencing data I use for this project was generated using an Illumina HiSeq X10 with the Agilent SureSelect Mouse All Exon Kit. The tissue used was collected from FVB/NJ mice, which is reflected in the choice of SNP and InDel files. All analyses are performed on a Unix-based operating system.
