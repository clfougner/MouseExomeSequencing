# Reference Files

Several reference files are required for this pipeline. These are updated reasonably regularly, and as a consequence of this, they aren't always readily found in the format you want them. This means that some processing/formatting of the files will be required before they can be used.

### Downloads
#### Mouse Reference Genome
The mouse reference genome is maintained by UCSC, and can be downloaded from [here](http://hgdownload.cse.ucsc.edu/goldenPath/mm10/bigZips/), filename `mm10.2bit`. This file needs to be converted to the FASTA file format (see "Preparing the Reference Files"). The latest version of the reference genome, mm10, will be used here. Note that the Genome Reference Consortium (GRC) maintains an almost identical reference genome, GRCm38.

#### Indels
The Sanger Institute maintains a list of SNPs and Indels for mice, which can be found through their FTP (`ftp://ftp-mouse.sanger.ac.uk/`). My work is using mice bred on an FVB/NJ background :`ftp://ftp-mouse.sanger.ac.uk/current_indels/strain_specific_vcfs/FVB_NJ.mgp.v5.indels.dbSNP142.normed.vcf.gz`.

#### SNPs
SNPs for FVB/NJ mice can be found here: `ftp://ftp-mouse.sanger.ac.uk/current_indels/strain_specific_vcfs/FVB_NJ.mgp.v5.snps.dbSNP142.vcf.gz`.

### Preparing the reference files

#### Mouse reference genome FASTA
As mentioned, the reference genome needs to be in the FASTA file format (.fa or .fasta) to be used in the analyses. The reference genome was downloaded in the .2bit file format, so the [TwoBitToFa](http://hgdownload.cse.ucsc.edu/admin/exe/macOSX.x86_64/) tool must be used.

`````
twoBitToFa /path/to/mm10.2bit /path/to/mm10.fa
`````

* [Documentation](https://genome.ucsc.edu/goldenpath/help/twoBit.html)

#### Reference genome BWA index
In order to use the Burrows-Wheeler aligner, the reference genome must be indexed using the [BWA framework](http://bio-bwa.sourceforge.net/).

`````
bwa index /path/to/mm10.fa
`````

* [Documentation](http://bio-bwa.sourceforge.net/bwa.shtml)

#### Create reference FASTA index
In order to use GATK, an index file for the reference genome must be created. This is done using Samtools.

`````
samtools faidx /path/to/mm10.fa
`````

* [Documentation](http://gatkforums.broadinstitute.org/gatk/discussion/1601/how-can-i-prepare-a-fasta-file-to-use-as-reference)

#### Create reference FASTA dictionary
In order to use GATK, an dictionary file for the reference FASTA must be created. This is done using Picard.

`````
java -jar /path/to/dist/picard.jar \
CreateSequenceDictionary \
REFERENCE=/path/to/mm10.fa \
OUTPUT=/path/to/mm10.dict
`````

* [Documentation](http://gatkforums.broadinstitute.org/gatk/discussion/1601/how-can-i-prepare-a-fasta-file-to-use-as-reference) /[also relevant](https://www.broadinstitute.org/gatk/guide/article?id=2798)

#### Correctly format the indel reference file
When realigning around indels, a list of known indels is used; this list must be correctly formatted to match the reference FASTA used for the alignment. This can be done using the script `FormatKnownIndels.sh`. Thanks to [John Longinotto](https://www.biostars.org/p/182917/#183000) for help with this issue. In this project, this file after processing is referred to as `mm10.FVBN.INDELS.vcf`.

#### Correctly format the SNP reference file
Same concept as with the indels; additionally, the SNP list must be sorted with Picard's `SortVcf`tool. The SNP reference file can be formatted with the script `FormatKnownSNPs.sh`. In this project, this file after processing is referred to as `mm10.FVBN.SNPs.vcf`.
