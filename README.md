#Mouse Exome Sequencing

This is a repository to document my work in setting up a pipeline for mouse exome sequencing. It is for my research use, but may act as a guideline for anyone looking to do accomplish the same goal. Most documents here are simple bash implementations of existing frameworks. The pipeline is mostly an implementation of the Broad Institutes's best practices for variant calling as presented [here](https://www.broadinstitute.org/gatk/guide/best-practices.php). Everything presented here is a work in progress, and there is no guarantee that any of the included scripts will work.

The exome sequencing data used for this project was generated at the TheragenEtex Institute in South Korea, using an Illumina HiSeq and the Agilent SureSelect Mouse All Exon Kit. The tissue used was collected from FVB/N mice, which is reflected in the choice of SNP and indel files.

