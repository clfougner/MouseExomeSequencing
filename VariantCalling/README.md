# Variant Calling

This pipeline is split into three parts: preprocessing, variant calling and annotation. This pipeline is an implementation of the [Broad Institute's best practices for variant calling](https://www.broadinstitute.org/gatk/guide/best-practices.php). Scripts found here are primarily simple bash implemenations of this pipeline. While annotation is strictly speaking a downstream analysis of called variants, I've included them in this folder as it's likely to be a part of everyone's analysis pipeline.

There is a script for a each step. All steps are also put together into a single script in `EntirePipeline.sh`. If all reference files are prepared according to the previous instructions and all required frameworks are installed, the entire pipeline from mapping to variant annotation can be run simply by replacing the paths to the relevant input, reference and framework files. Note that a number of folders are required (see lines 60-78 for names). Also, note that Picard is invoked here simply by inputting `picard`; depending on your installation you may have to replace the relevant lines with `java -jar dist/picard.jar`.

## Preprocessing
#### 1) Cutadapt
Cutadapt finds and removes adapter sequences, primers, poly-A tails and other types of unwanted sequence from your high-throughput sequencing reads.

```
Script:           CutAdapt.sh
Using framework:  cutadapt
```
* [Documentation](https://cutadapt.readthedocs.io/en/stable/)

#### 2) Sickle
Most modern sequencing technologies produce reads that have deteriorating quality towards the 3'-end and some towards the 5'-end as well. Incorrectly called bases in both regions negatively impact assembles, mapping, and downstream bioinformatics analyses. Sickle is a tool that uses sliding windows along with quality and length thresholds to determine when quality is sufficiently low to trim the 3'-end of reads and also determines when the quality is sufficiently high enough to trim the 5'-end of reads.
```
Script:           Sickle.sh
Using framework:  sickle
Using method:     pe
```
* [Documentation](https://github.com/najoshi/sickle)

#### 3) Map reads to produce BAM file
Map reads to the reference genome using BWA:
```
Script:           BWAmem.sh
Reference file:   mm10.fa
Using framework:  Burrows-Wheeler Aligner (BWA)
Using method:     mem
```
* [Documentation](http://bio-bwa.sourceforge.net/bwa.shtml)

#### 4) Realign BAM file by coordinate
In order to remove duplicates (dedup), the BAM file must first be sorted by coordinate:
```
Script:           SortSam.sh
Using framework:  Picard
Using method:     SortSam
```
* [Documentation](https://broadinstitute.github.io/picard/command-line-overview.html#SortSam)

#### 5) Remove duplicates from BAM files
During the sequencing process, the same DNA fragments may be sequenced several times. The resulting duplicate reads are not informative and should not be counted as additional evidence for or against a putative variant. The duplicate marking process does not remove the reads, but identifies them as duplicates by adding a flag in the read's SAM record. Most GATK tools will then ignore these duplicate reads by default, through the internal application of a read filter [(2)](https://www.broadinstitute.org/gatk/guide/bp_step.php?p=1).
```
Script:           MarkDuplicates.sh
Using framework:  Picard
Using method:     MarkDuplicates
```
* [Documentation](https://broadinstitute.github.io/picard/command-line-overview.html#MarkDuplicates)

#### 6) Realign around indels

NOTE: As of [GATK version 3.6](http://gatkforums.broadinstitute.org/gatk/discussion/7712/version-highlights-for-gatk-version-3-6) realigment around indels is no longer recommended as part of the best practices workflow. Nonetheless, I'm leaving the scripts for it here in case it's of interest to anyone, but the steps have been removed from `EntirePipeline.sh`.

The algorithms that are used in the initial mapping step tend to produce various types of artifacts. For example, reads that align on the edges of indels often get mapped with mismatching bases that might look like evidence for SNPs, but are actually mapping artifacts. The realignment process identifies the most consistent placement of the reads relative to the indel in order to clean up these artifacts. It occurs in two steps: first the program identifies intervals that need to be realigned, then in the second step it determines the optimal consensus sequence and performs the actual realignment of reads.

This step used to be very important when the the variant callers were position-based (such as UnifiedGenotyper) but now that we have assembly-based variant callers (such as HaplotypeCaller) it is less important. We still perform indel realignment because we think it may improve the accuracy of the base recalibration model in the next step, but this step may be made obsolete in the near future [(3)](https://www.broadinstitute.org/gatk/guide/bp_step.php?p=1).

###### First step:
```
Script:           RealignerTargetCreator.sh
Reference file:   mm10.fa
Known indels:     mm10.FVBN.INDELS.vcf
Using framework:  Genome Analysis Toolkit
Using method:     RealignerTargetCreator
```

###### Second step:
```
Script:           IndelRealigner.sh
Reference file:   mm10.fa
Known indels:     mm10.FVBN.INDELS.vcf
Using framework:  Genome Analysis Toolkit
Using method:     IndelRealigner
```
* [Documentation](https://www.broadinstitute.org/gatk/guide/article?id=38)

#### 7) Recalibrate bases
Variant calling algorithms rely heavily on the quality scores assigned to the individual base calls in each sequence read. These scores are per-base estimates of error emitted by the sequencing machines. Unfortunately the scores produced by the machines are subject to various sources of systematic technical error, leading to over- or under-estimated base quality scores in the data. Base quality score recalibration (BQSR) is a process in which we apply machine learning to model these errors empirically and adjust the quality scores accordingly. This allows us to get more accurate base qualities, which in turn improves the accuracy of our variant calls [(4)](https://www.broadinstitute.org/gatk/guide/bp_step.php?p=1).

###### First step:
```
Script:           BaseRecalibrator.sh
Reference file:   mm10.fa
Known indels:     mm10.FVBN.INDELS.vcf
Known SNPs:       mm10.FVBN.SNPs.vcf
Using framework:  Genome Analysis Toolkit
Using Method:     BaseRecalibrator
````

###### Second step:
```
Script:           BaseRecalibratorSecondPass.sh
Reference file:   mm10.fa
Known indels:     mm10.FVBN.INDELS.vcf
Known SNPs:       mm10.FVBN.SNPs.vcf
Using framework:  Genome Analysis Toolkit
Using Method:     BaseRecalibrator
````

###### Third step:
```
Script:             AnalyzeCovariates.sh
Reference file:     mm10.fa
Using framework:    Genome Analysis Toolkit
Using Method:       AnalyzeCovariates
````

###### Fourth Step:
```
Script:             PrintReads.sh
Reference file:     mm10.fa
Using framework:    Genome Analysis Toolkit
Using Method:       PrintReads
````
* [Documentation](https://www.broadinstitute.org/gatk/guide/article?id=2801)

## Variant calling
In this step, variants are called relative to the reference genome, and then marked if evidence for them is found in the matched normal sample or in the list of known SNPs.
```
Script:           MuTect.sh
Reference file:   mm10.fa
SNP file:         mm10.FVBN.SNPs.vcf
Using framework:  Genome Analysis Toolkit
Method:           MuTect2
````
* [Documentation](https://www.broadinstitute.org/gatk/guide/tooldocs/org_broadinstitute_gatk_tools_walkers_cancer_m2_MuTect2.php)


## Variant processing
#### 1) Annotate variants
SnpEff annotates the variants found from MuTect. The most important information includes the gene names and effect (i.e. missense, synonymous, etc.)
```
Script:           SnpEff.sh
Reference:        GRCm38.82
Using framework:  SnpEff
```
* [Documentation](http://snpeff.sourceforge.net/SnpEff_manual.html#run)

#### 2) Filter variants for passing MuTect filters
This step filters the annotated variants for only those passing MuTect's filters.

`````
Script:           SnpSiftForPass.sh
Using framework:  SnpSift (part of SnpEff)
Using method:     filter
`````

*[Documentation](http://snpeff.sourceforge.net/SnpSift.html)

#### 3) Extract variants to text file
This step extracts the passed filters to a .txt file which is more easily readable and (arguably) better for downstream analyses.

`````
Script:             SnpSiftExtract.sh
Using framework:    SnpSift (part of SnpEff)
Using method:       extractFields
`````

*[Documentation](http://snpeff.sourceforge.net/SnpSift.html)
