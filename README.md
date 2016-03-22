#Mouse Exome Sequencing

This is a repository to document my work in setting up a pipeline for mouse exome sequencing. It is for my research use, but may act as a guideline for anyone looking to do accomplish the same goal. Most documents here are simple bash implementations of existing frameworks. The pipeline is mostly an implementation of the Broad Institutes's best practices for variant calling as presented [here](https://www.broadinstitute.org/gatk/guide/best-practices.php). Everything presented here is a working progress, and there is no guarantee that any of the included scripts will work.

The exome sequencing data used for this project was generated at the TheragenEtex Insitute in South Korea, using an Illumina HiSeq and the Agilent SureSelect All Mouse All Exon Kit. The tissue used was collected from FVB/N mice, which is reflected in the choice of SNP and indel files.


##Required Frameworks

####Genome Analysis Toolkit
As the name implies, the Genome Analysis Toolkit (GATK) is a framework for analysing sequencing data, including exome sequencing. The primary use of GATK in this pipeline is for the mutation calling itself, using the MuTect command. GATK is created by the Broad Institute, and can be downloaded [here](https://www.broadinstitute.org/gatk/download/). Login is required to download. Java (see below) is required to run GATK. All work presented here is using the Genome Analysis Toolkit version 3.5

####Burrows-Wheeler Aligner
Burrows-Wheeler Aligner is a framework which allows us to align reads in the FASTQ format to .bam files. It can be downloaded from [here](http://bio-bwa.sourceforge.net/). All work presented here is using BWA version 0.7.12.

####Picard
Picard is a toolkit for manipulating sequence data formats, including BAM/SAM/CRAM and VCF. It is also created by the Broad Institute, and can be downloaded [here](http://broadinstitute.github.io/picard/). Java, HTSJDK and Ant (see below) are required to rum Picard. All work presented here is using Picard version 2.0.1. 

####Samtools
Samtools is another toolkit for manipulating and viewing sequence data formats, and can be downloaded [here](http://www.htslib.org/). Java (see below) is required to run Samtools. All work presented here is using Samtools version 1.3.

####TwoBitToFa
Framework for converting .2bit files to .fa (fasta) files, created by UCSC, and can be downloaded for Mac/OSX [here](http://hgdownload.cse.ucsc.edu/admin/exe/macOSX.x86_64/) (filename `twoBitToFa`).

####Java
Java is required for almost all frameworks listed, and can be downloaded [here](https://java.com/en/download/). All work presented here is running Java build 1.8.

####HTSJDK
High Throughput Sequencing Java Development Kit (HTSJDK) is is a Java API for high throughput sequencing data formats and can be downloaded through [here](http://samtools.github.io/htsjdk/). HTSJDK is most notably required in order to use Picard. All work presented here is using HTSJDK version 2.0.1. 

####Apache Ant
Ant is required for building HTSJDK, and can be downloaded [here](http://ant.apache.org/). All work presented here is using Ant version 1.9.6.


##Necessary Reference Files

####Mouse Reference Genome: mm10.2bit
The mouse reference genome is maintained by UCSC, and can be downloaded from [here](http://hgdownload.cse.ucsc.edu/goldenPath/mm10/bigZips/), filename `mm10.2bit`. In order to actually use this file, we'll need to convert it to the FASTA file format, but we'll get to that in a bit (see header "Manipulating the Reference Files").The latest version of the reference genome, mm10, will be used here. Note that the Genome Reference Consortium (GRC) maintains an almost identical reference genome, GRCm38.

####Indels and SNPs
The Sanger Institute maintains a list of SNPs and Indels for mice, which can be found through their FTP (`ftp://ftp-mouse.sanger.ac.uk/`). My work is using mice bred on a pure FVB/N background, and I will consequently be using the list of SNPs and indels found through their FTP (`ftp://ftp-mouse.sanger.ac.uk/REL-1206-FVBNJ/`), filename `2012-0612-snps+indels_FVBNJ_annotated.vcf.gz`.

###Manipulating the reference files

####Mouse reference genome FASTA
As mentioned, the reference genome needs to be in the FASTA file format (.fa or .fasta) to be used in the analyses. The reference genome was downloaded in the .2bit file format, so the `TwoBitToFa` tool must be used. A simple script for this is found in `TwoBitToFa.sh`.

####Reference genome BWA-index
In order to use the burrows wheeler aligner, the reference genome must be indexed using the BWA-framework. A simple script for this is found in `BWAIndex.sh`.

####Create refence FASTA-index
In order to run MuTect, an index file for the reference FASTA must be created. This is done using Samtools. A simple script for this is found in `CreateFastaFileIndex.sh`.


##Call Variants
####1) Raw reads to FASTQ file
First off, raw reads must be turned into a FASTQ file. In my case, this was done for me by the sequencing service, and will not be mentioned further

####2) Map reads to produce BAM file 
Second, the reads must be mapped to the reference genome:
```
Script:				MapReadsWithBWAmem.sh
Reference file:		mm10.fa
Using framework:	Burrows Wheeler Aligner (BWA)
Using method:		mem
```
* [Documentation](http://bio-bwa.sourceforge.net/bwa.shtml)

####3) Realign BAM file by coordinate
In order to remove duplicates (dedup), the BAM file must be sorted by coordinate:
```
Script:				SortSam.sh
Using framework:	Picard
Using method:		SortSam
```
* [Documentation](https://broadinstitute.github.io/picard/command-line-overview.html#SortSam)

####4) Remove duplicates from BAM files
during the sequencing process, the same DNA fragments may be sequenced several times. The resulting duplicate reads are not informative and should not be counted as additional evidence for or against a putative variant. The duplicate marking process (sometimes called **dedupping** in bioinformatics slang) does not remove the reads, but identifies them as duplicates by adding a flag in the read's SAM record. Most GATK tools will then ignore these duplicate reads by default, through the internal application of a read filter [(1)](https://www.broadinstitute.org/gatk/guide/bp_step.php?p=1).
```
Script:				MarkDuplicatesPicard.sh
Using framework:	Picard
Using method:		MarkDuplicates
```
* [Documentation](https://broadinstitute.github.io/picard/command-line-overview.html#MarkDuplicates)

####5) Create Realigner Target
The algorithms that are used in the initial mapping step tend to produce various types of artifacts. For example, reads that align on the edges of indels often get mapped with mismatching bases that might look like evidence for SNPs, but are actually mapping artifacts. The realignment process identifies the most consistent placement of the reads relative to the indel in order to clean up these artifacts. It occurs in two steps: first the program identifies intervals that need to be realigned, then in the second step it determines the optimal consensus sequence and performs the actual realignment of reads.

This step used to be very important when the the variant callers were position-based (such as UnifiedGenotyper) but now that we have assembly-based variant callers (such as HaplotypeCaller) it is less important. We still perform indel realignment because we think it may improve the accuracy of the base recalibration model in the next step, but this step may be made obsolete in the near future.[(2)](https://www.broadinstitute.org/gatk/guide/bp_step.php?p=1).
```
Script:				RealignerTargetCreator.sh
Reference file: 	mm10.fa
Known indels: 		2012-0612-snps+indels_FVBNJ_annotated.vcf
Using framework:	Genome Analysis Toolkit	
Using method:		RealignerTargetCreator
```
* [Documentation](https://www.broadinstitute.org/gatk/guide/article?id=2800)

####6) Realign around indels
This is a continuation of the previous step:
```
Script:					IndelRealigner.sh
Reference file:			mm10.fa
Known indels: 			2012-0612-snps+indels_FVBNJ_annotated.vcf
Using framework:		Genome Analysis Toolkit
Using method:			IndelRealigner
```
* [Documentation](https://www.broadinstitute.org/gatk/guide/article?id=38)

####7) Recalibrate bases: COMING SOON

####8) Call variants
```
Script: 				MuTect.sh
Reference file:			mm10.fa
SNP file:		    	2012-0612-snps+indels_FVBNJ_annotated.vcf
Using framework:		Genome Analysis Toolkit
Method:		  	  	    MuTect2
````
* [Documentation](https://www.broadinstitute.org/gatk/guide/tooldocs/org_broadinstitute_gatk_tools_walkers_cancer_m2_MuTect2.php)

####9) Annotate variants
```
Script:					SnpEff.sh
Reference:		   	    GRCm38.82
Using framework:		SnpEff
Using method:			SnpEff.jar
````
* [Documentation](http://snpeff.sourceforge.net/SnpEff_manual.html#run)

####10) Filter variants for passing MuTect filters
```
Script:					SnpSiftForPass.sh
Using framework:		SnpEff
Using method			SnpSift.jar
```
*[Documentation](http://snpeff.sourceforge.net/SnpSift.html)


######Other:

Reorder BAM to reference file
```
Script:					reorderBamToReference.sh
Reference:		        mm10.fa
Using framework:		Picard
Using method:			ReorderSam
```
* [Documentation](https://broadinstitute.github.io/picard/command-line-overview.html#ReorderSam)
