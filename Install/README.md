#Frameworks [(1)](https://www.broadinstitute.org/gatk/guide/article?id=2899)

The scripts found in this folder are simple bash implementations of the instructions found on the respective frameworks' websites. The variant calling pipeline is mostly an implementation of the [Broad Institute's best practices for variant calling](https://www.broadinstitute.org/gatk/guide/best-practices.php), which is reflected in the frameworks presented here.


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
High Throughput Sequencing Java Development Kit (HTSJDK) is is a Java API for high throughput sequencing data formats and can be downloaded [here](http://samtools.github.io/htsjdk/). HTSJDK is required in order to use Picard. All work presented here is using HTSJDK version 2.0.1. 

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
install.packages("plyr")
```

####Pip
This is a python package used to install Cutadapt (note: some users may already have this installed). Follow the instructions [here](https://pip.pypa.io/en/stable/installing/) to install.

####Cutadapt
Framework required to remove adapter sequences from reads. Follow the instructions [here](http://cutadapt.readthedocs.io/en/stable/installation.html) to install.

####Sickle
Sickle is used to trim low quality reads. In order to install, clone the repository from [here](https://github.com/najoshi/sickle). Change directory to the folder and enter the following:
```
make
export PATH=$PATH:~/opt/bin
````
