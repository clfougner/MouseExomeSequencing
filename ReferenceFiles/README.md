# Reference Files

A number of reference files are needed for the analyses found in this repository. These are updated reasonably regularly, and as a consequence of this, they aren't always readily found in the format you want them. This means that some processing/formatting of the files will be required before they can be used.

### Downloads
#### Mouse Reference Genome
The mouse reference genome is maintained by UCSC, and can be downloaded from [here](http://hgdownload.cse.ucsc.edu/goldenPath/mm10/bigZips/), filename `mm10.2bit`. In order to actually use this file, we'll need to convert it to the FASTA file format, but we'll get to that in a bit (see "Preparing the Reference Files"). The latest version of the reference genome, mm10, will be used here. Note that the Genome Reference Consortium (GRC) maintains an almost identical reference genome, GRCm38.

#### Indels
The Sanger Institute maintains a list of SNPs and Indels for mice, which can be found through their FTP (`ftp://ftp-mouse.sanger.ac.uk/`). My work is using mice bred on a pure FVB/N background, and I will consequently be using the list of indels found for this specific strain: `ftp://ftp-mouse.sanger.ac.uk/current_indels/strain_specific_vcfs/FVB_NJ.mgp.v5.indels.dbSNP142.normed.vcf.gz`.

#### SNPs
A list of SNPs for FVB/N mice can be found here: `ftp://ftp-mouse.sanger.ac.uk/current_indels/strain_specific_vcfs/FVB_NJ.mgp.v5.snps.dbSNP142.vcf.gz`.

### Preparing the reference files

#### Mouse reference genome FASTA
As mentioned, the reference genome needs to be in the FASTA file format (.fa or .fasta) to be used in the analyses. The reference genome was downloaded in the .2bit file format, so the `TwoBitToFa` tool must be used. A simple script for this is found in `TwoBitToFa.sh`.
* [Documentation](https://genome.ucsc.edu/goldenpath/help/twoBit.html)

#### Reference genome BWA index
In order to use the Burrows-Wheeler aligner, the reference genome must be indexed using the BWA framework. A simple script for this is found in `BWAIndex.sh`.
* [Documentation](http://bio-bwa.sourceforge.net/bwa.shtml)

#### Create reference FASTA index
In order to use GATK, an index file for the reference FASTA must be created. This is done using Samtools. A simple script for this is found in `CreateFastaFileIndex.sh`.
* [Documentation](http://gatkforums.broadinstitute.org/gatk/discussion/1601/how-can-i-prepare-a-fasta-file-to-use-as-reference)

#### Create reference FASTA dictionary
In order to use GATK, an dictionary file for the reference FASTA must be created. This is done using Picard. A simple script for this is found in `CreateSequenceDictionary.sh`.
* [Documentation](http://gatkforums.broadinstitute.org/gatk/discussion/1601/how-can-i-prepare-a-fasta-file-to-use-as-reference)

#### Correctly format the indel reference file
When realigning around indels, a list of known indels is used; this list must be correctly formatted to match the reference FASTA used for the alignment. This can be done using the script `FormatKnownIndels.sh`. Thanks to [John Longinotto](https://www.biostars.org/p/182917/#183000) for help with this! In this project, this file after processing is referred to as `mm10.FVBN.INDELS.vcf`.

#### Correctly format the SNP reference file
Same concept as with the indels; additionally, the SNP list must be sorted with Picard's `SortVcf`tool. The SNP reference file can be formatted with the script `FormatKnownSNPs.sh`. In this project, this file after processing is referred to as `mm10.FVBN.SNPs.vcf`.
