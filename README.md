#Mouse Exome Sequencing

This is a repository to document my work in setting up a pipeline for mouse exome sequencing. It is for my research use, but may act as a guideline for anyone looking to do accomplish the same goal. Most documents here are simple bash implementations of existing frameworks. The pipeline is mostly an implementation of the Broad Institutes's best practices for variant calling as presented [here](https://www.broadinstitute.org/gatk/guide/best-practices.php). Everything presented here is a work in progress, and there is no guarantee that any of the included scripts will work.

The exome sequencing data used for this project was generated at the TheragenEtex Institute in South Korea, using an Illumina HiSeq and the Agilent SureSelect Mouse All Exon Kit. The tissue used was collected from FVB/N mice, which is reflected in the choice of SNP and indel files.


##Frameworks [(1)](https://www.broadinstitute.org/gatk/guide/article?id=2899)

####Genome Analysis Toolkit
The Genome Analysis Toolkit (GATK) is a framework for analysing sequencing data, including exome sequencing. The primary use of GATK in this pipeline is for the mutation calling itself, using the MuTect command. GATK is created and maintained by the Broad Institute, and can be downloaded [here](https://www.broadinstitute.org/gatk/download/). Login is required to download. Java (see below) is required to run GATK. All work presented here is using the Genome Analysis Toolkit version 3.5

####Burrows-Wheeler Aligner
Burrows-Wheeler Aligner is a framework which allows us to align reads in the FASTQ format to a reference genome, producing .bam files. It can be downloaded from [here](http://bio-bwa.sourceforge.net/). All work presented here is using BWA version 0.7.12.

####Picard
Picard is a toolkit for manipulating sequence data formats, including BAM/SAM/CRAM and VCF. It is also created by the Broad Institute, and can be downloaded [here](http://broadinstitute.github.io/picard/). Java, HTSJDK and Ant (see below) are required to run Picard. All work presented here is using Picard version 2.0.1. 

####Samtools
Samtools is another toolkit for manipulating and viewing sequence data formats, and can be downloaded [here](http://www.htslib.org/). Java (see below) is required to run Samtools. All work presented here is using Samtools version 1.3.

####TwoBitToFa
Framework for converting .2bit files to .fa (fasta) files, created by UCSC, and can be downloaded for Mac/OSX [here](http://hgdownload.cse.ucsc.edu/admin/exe/macOSX.x86_64/) (filename `twoBitToFa`).

####Java
Java is required for almost all frameworks listed, and can be downloaded [here](https://java.com/en/download/). All work presented here is running Java version 1.8.

####HTSJDK
High Throughput Sequencing Java Development Kit (HTSJDK) is is a Java API for high throughput sequencing data formats and can be downloaded [here](http://samtools.github.io/htsjdk/). HTSJDK is most required in order to use Picard. All work presented here is using HTSJDK version 2.0.1. 

####Apache Ant
Ant is required for building HTSJDK, and can be downloaded [here](http://ant.apache.org/). All work presented here is using Ant version 1.9.6.

####Gawk
Awk is a programming language which can be used for simple data reformatting jobs. Gawk is the GNU implementation of awk, and can be downloaded from [here](http://www.gnu.org/software/gawk/). It is required for the script used to reformat reference SNP and indel files.

####R
To generate plots in the base quality score recalibration step, [R](https://www.r-project.org/) or [RStudio](https://www.rstudio.com/products/rstudio/#Desktop) must be installed. Further, the packages "gplots", "reshape", "ggplot2" and "gsalib" must be installed. This can be done by entering the following commands into your R console:
```
install.packages("gplots")
install.packages("reshape")
install.packages("ggplot2")
install.packages("gsalib")
```

##Reference Files

####Mouse Reference Genome: mm10.2bit
The mouse reference genome is maintained by UCSC, and can be downloaded from [here](http://hgdownload.cse.ucsc.edu/goldenPath/mm10/bigZips/), filename `mm10.2bit`. In order to actually use this file, we'll need to convert it to the FASTA file format, but we'll get to that in a bit (see "Preparing the Reference Files"). The latest version of the reference genome, mm10, will be used here. Note that the Genome Reference Consortium (GRC) maintains an almost identical reference genome, GRCm38.

####Indels
The Sanger Institute maintains a list of SNPs and Indels for mice, which can be found through their FTP (`ftp://ftp-mouse.sanger.ac.uk/`). My work is using mice bred on a pure FVB/N background, and I will consequently be using the list of indels found for this specific strain: `ftp://ftp-mouse.sanger.ac.uk/current_indels/strain_specific_vcfs/FVB_NJ.mgp.v5.indels.dbSNP142.normed.vcf.gz`.

####SNPs
A list of SNPs for FVB/N mice can be found here: `ftp://ftp-mouse.sanger.ac.uk/current_indels/strain_specific_vcfs/FVB_NJ.mgp.v5.snps.dbSNP142.vcf.gz`.

###Preparing the reference files

####Mouse reference genome FASTA
As mentioned, the reference genome needs to be in the FASTA file format (.fa or .fasta) to be used in the analyses. The reference genome was downloaded in the .2bit file format, so the `TwoBitToFa` tool must be used. A simple script for this is found in `TwoBitToFa.sh`.
* [Documentation](https://genome.ucsc.edu/goldenpath/help/twoBit.html)

####Reference genome BWA index
In order to use the Burrows-Wheeler aligner, the reference genome must be indexed using the BWA framework. A simple script for this is found in `BWAIndex.sh`.
* [Documentation](http://bio-bwa.sourceforge.net/bwa.shtml)

####Create reference FASTA index
In order to use GATK, an index file for the reference FASTA must be created. This is done using Samtools. A simple script for this is found in `CreateFastaFileIndex.sh`.
* [Documentation](http://gatkforums.broadinstitute.org/gatk/discussion/1601/how-can-i-prepare-a-fasta-file-to-use-as-reference)

####Create reference FASTA dictionary
In order to use GATK, an dictionary file for the reference FASTA must be created. This is done using Picard. A simple script for this is found in `CreateSequenceDictionary.sh`.
* [Documentation](http://gatkforums.broadinstitute.org/gatk/discussion/1601/how-can-i-prepare-a-fasta-file-to-use-as-reference)

####Correctly format the indel reference file
When realigning around indels, a list of known indels is used; this list must be correctly formatted to match the reference FASTA used for the alignment. This can be done using the script `FormatKnownIndels.sh`. Thanks to [John Longinotto](https://www.biostars.org/p/182917/#183000) for help with this! In this project, this file after processing is referred to as `mm10.FVBN.INDELS.vcf`.

####Correctly format the SNP reference file
Same concept as with the indels; additionally, the SNP list must be sorted with Picard's `SortVcf`tool. The SNP reference file can be formatted with the script `FormatKnownSNPs.sh`. In this project, this file after processing is referred to as `mm10.FVBN.SNPs.vcf`.

##Preprocessing
####1) Raw reads to FASTQ file
First off, raw reads must be turned into a FASTQ file. In my case, this was done for me by the sequencing service, and will not be mentioned further

####2) Map reads to produce BAM file 
Second, the reads must be mapped to the reference genome:
```
Script:				BWAmem.sh
Reference file:		mm10.fa
Using framework:	Burrows-Wheeler Aligner (BWA)
Using method:		mem
```
* [Documentation](http://bio-bwa.sourceforge.net/bwa.shtml)

####3) Realign BAM file by coordinate
In order to remove duplicates (dedup), the BAM file must first be sorted by coordinate:
```
Script:				SortSam.sh
Using framework:	Picard
Using method:		SortSam
```
* [Documentation](https://broadinstitute.github.io/picard/command-line-overview.html#SortSam)

####4) Remove duplicates from BAM files
During the sequencing process, the same DNA fragments may be sequenced several times. The resulting duplicate reads are not informative and should not be counted as additional evidence for or against a putative variant. The duplicate marking process (sometimes called **dedupping** in bioinformatics slang) does not remove the reads, but identifies them as duplicates by adding a flag in the read's SAM record. Most GATK tools will then ignore these duplicate reads by default, through the internal application of a read filter [(2)](https://www.broadinstitute.org/gatk/guide/bp_step.php?p=1).
```
Script:				MarkDuplicates.sh
Using framework:	Picard
Using method:		MarkDuplicates
```
* [Documentation](https://broadinstitute.github.io/picard/command-line-overview.html#MarkDuplicates)

####5) Realign around indels
The algorithms that are used in the initial mapping step tend to produce various types of artifacts. For example, reads that align on the edges of indels often get mapped with mismatching bases that might look like evidence for SNPs, but are actually mapping artifacts. The realignment process identifies the most consistent placement of the reads relative to the indel in order to clean up these artifacts. It occurs in two steps: first the program identifies intervals that need to be realigned, then in the second step it determines the optimal consensus sequence and performs the actual realignment of reads.

This step used to be very important when the the variant callers were position-based (such as UnifiedGenotyper) but now that we have assembly-based variant callers (such as HaplotypeCaller) it is less important. We still perform indel realignment because we think it may improve the accuracy of the base recalibration model in the next step, but this step may be made obsolete in the near future [(3)](https://www.broadinstitute.org/gatk/guide/bp_step.php?p=1).

######First step:
```
Script:				RealignerTargetCreator.sh
Reference file: 	mm10.fa
Known indels: 		mm10.FVBN.INDELS.vcf
Using framework:	Genome Analysis Toolkit	
Using method:		RealignerTargetCreator
```

######Second step:
```
Script:					IndelRealigner.sh
Reference file:			mm10.fa
Known indels: 			mm10.FVBN.INDELS.vcf
Using framework:		Genome Analysis Toolkit
Using method:			IndelRealigner
```
* [Documentation](https://www.broadinstitute.org/gatk/guide/article?id=38)

####6) Recalibrate bases
Variant calling algorithms rely heavily on the quality scores assigned to the individual base calls in each sequence read. These scores are per-base estimates of error emitted by the sequencing machines. Unfortunately the scores produced by the machines are subject to various sources of systematic technical error, leading to over- or under-estimated base quality scores in the data. Base quality score recalibration (BQSR) is a process in which we apply machine learning to model these errors empirically and adjust the quality scores accordingly. This allows us to get more accurate base qualities, which in turn improves the accuracy of our variant calls [(4)](https://www.broadinstitute.org/gatk/guide/bp_step.php?p=1).

######First step:
```
Script:             BaseRecalibrator.sh
Reference file:     mm10.fa
Known indels:       mm10.FVBN.INDELS.vcf
Known SNPs:         mm10.FVBN.SNPs.vcf
Using framework:    Genome Analysis Toolkit
Using Method:       BaseRecalibrator
````

######Second step:
```
Script:             BaseRecalibratorSecondPass.sh
Reference file:     mm10.fa
Known indels:       mm10.FVBN.INDELS.vcf
Known SNPs:         mm10.FVBN.SNPs.vcf
Using framework:    Genome Analysis Toolkit
Using Method:       BaseRecalibrator
````

######Third step:
```
Script:             AnalyzeCovariates.sh
Reference file:     mm10.fa
Using framework:    Genome Analysis Toolkit
Using Method:       AnalyzeCovariates
````

######Fourth Step:
```
Script:             PrintReads.sh
Reference file:     mm10.fa
Using framework:    Genome Analysis Toolkit
Using Method:       PrintReads
````
* [Documentation](https://www.broadinstitute.org/gatk/guide/article?id=2801)

##Variant calling
In this step, variants are called relative to the reference genome, and then marked if evidence for them is found in the matched normal sample or in the list of known SNPs.
```
Script: 				MuTect.sh
Reference file:			mm10.fa
SNP file:		    	mm10.FVBN.SNPs.vcf
Using framework:		Genome Analysis Toolkit
Method:		  	  	    MuTect2
````
* [Documentation](https://www.broadinstitute.org/gatk/guide/tooldocs/org_broadinstitute_gatk_tools_walkers_cancer_m2_MuTect2.php)


##Variant processing
####1) Annotate variants
SnpEff annotates the variants found from MuTect. The most important information includes the gene names and effect (i.e. missense, synonymous, etc.)
```
Script:					SnpEff.sh
Reference:		   	    GRCm38.82
Using framework:		SnpEff
````
* [Documentation](http://snpeff.sourceforge.net/SnpEff_manual.html#run)

####2) Filter variants for passing MuTect filters
This step filters the annotated variants for only those passing MuTect's filters.
```
Script:				     	SnpSiftForPass.sh
Using framework:		SnpSift (part of SnpEff)
Using method:		  	filter
```
*[Documentation](http://snpeff.sourceforge.net/SnpSift.html)

####3) Extract variants to text file
This step extracts the passed filters to a .txt file which is more easily readable and better for downstream analyses.
````
Script:             SnpSiftExtract.sh
Using framework:    SnpSift (part of SnpEff)
Using method:       extractFields
```
*[Documentation](http://snpeff.sourceforge.net/SnpSift.html)
