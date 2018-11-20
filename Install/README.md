# Frameworks [(1)](https://www.broadinstitute.org/gatk/guide/article?id=2899)

This file presents the frameworks/packages required for the pipeline. It is mostly an implementation of the [Broad Institute's best practices for variant calling](https://www.broadinstitute.org/gatk/guide/best-practices.php).


#### Genome Analysis Toolkit
The Genome Analysis Toolkit (GATK) is a framework for analysing sequencing data, including exome sequencing. The primary use of GATK in this pipeline is for the mutation calling itself, using the MuTect command. GATK is maintained by the Broad Institute, and can be downloaded [here](https://www.broadinstitute.org/gatk/download/). Login is required to download. Java is required to run GATK. All work presented here is using the Genome Analysis Toolkit version 3.5

#### Burrows-Wheeler Aligner
The Burrows-Wheeler Aligner allows us to align reads in the FASTQ format to a reference genome, producing .bam files. It can be downloaded from [here](http://bio-bwa.sourceforge.net/). All work presented here is using BWA version 0.7.12.

#### Picard
Picard is a toolkit for manipulating sequence data formats, including BAM/SAM/CRAM and VCF. It is also maintained by the Broad Institute, and can be downloaded [here](http://broadinstitute.github.io/picard/). Java, HTSJDK and Ant are required to run Picard. All work presented here is using Picard version 2.0.1.

#### Samtools
Samtools is another toolkit for manipulating and viewing sequence data formats, and can be downloaded [here](http://www.htslib.org/). Java is required to run Samtools. All work presented here is using Samtools version 1.3.

#### TwoBitToFa
Framework for converting .2bit files to .fa (fasta) files, created by UCSC, and can be downloaded for MacOS [here](http://hgdownload.cse.ucsc.edu/admin/exe/macOSX.x86_64/) (filename `twoBitToFa`). Use `chmod +x twoBitToFa` to make the file executable.

#### Java
Java is required for almost all frameworks listed, and can be downloaded [here](https://java.com/en/download/). All work presented here is running Java version 1.8.

#### HTSJDK
High Throughput Sequencing Java Development Kit (HTSJDK) is is a Java API for high throughput sequencing data formats and can be downloaded [here](http://samtools.github.io/htsjdk/). HTSJDK is required in order to use Picard. All work presented here is using HTSJDK version 2.0.1.

#### Apache Ant
Ant is required for building HTSJDK, and can be downloaded [here](http://ant.apache.org/). All work presented here is using Ant version 1.9.6.

#### Gawk
Awk is a programming language which can be used for simple data reformatting jobs. Gawk is the GNU implementation of awk, and can be downloaded from [here](http://www.gnu.org/software/gawk/). It is required for the script used to reformat reference SNP and indel files.

#### R
To generate plots in the base quality score recalibration step, [R](https://www.r-project.org/) or [RStudio](https://www.rstudio.com/products/rstudio/#Desktop) must be installed.

#### Pip
This is a python package used to install Cutadapt. Follow the instructions [here](https://pip.pypa.io/en/stable/installing/) to install.

#### Cutadapt
Framework required to remove adapter sequences from reads. Follow the instructions [here](http://cutadapt.readthedocs.io/en/stable/installation.html) to install.

#### Sickle
Sickle is used to trim low quality reads. In order to install, clone the repository from [here](https://github.com/najoshi/sickle) and follow the instructions.

#### SnpEff
SnpEff is a variant annotation software. SnpEff can be downloaded from [here](http://sourceforge.net/projects/snpeff/files/snpEff_latest_core.zip).
