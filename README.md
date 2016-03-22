Sequencing plan

1) Raw reads FASTQ file -> Cutadapt/Sickle
	DONE BY THERAGEN

2) Map reads to produce BAM file 
	DONE BY USING:		./Scripts/MapReadsWithBWAmem.sh
	REFERENCE FILE: 	./ReferenceFiles/mm10.fa
	WITH FRAMEWORK:		./Frameworks/bwa-0.7.12/	:	mem

3 Realign BAM file by coordinate
	DONE BY USING: 		./Scripts/SortSam.sh
	With Framework:		./Frameworks/Picard/		:	SortSam

4) Dedup files using MarkDuplicates
	DONE BY USING:		./Scripts/MarkDuplicatesPicard.sh
	WITH FRAMEWORK:		./Frameworks/Picard/		:	MarkDuplicates

5) Create Realigner Target 		- not tested
	DONE BY USING:		./Scripts/RealignerTargetCreator.sh
	REFERENCE FILE: 	./ReferenceFiles/mm10.fa
	SNP FILE: 		./RefeferenceFiles/2012-0612-snps+indels_FVBNJ_annotated_reordered.vcf
	WITH FRAMEWORK:		./Frameworks/GenomeAnalysisTK-3.5 : GenomeAnalysisTK.jar	-T RealignerTargetCreator

6) Realign around indels		- not tested
	DONE BY USING:		./Scripts/IndelRealigner.sh
	REFERENCE FILE: 	./ReferenceFiles/mm10.fa
	SNP FILE: 		./RefeferenceFiles/2012-0612-snps+indels_FVBNJ_annotated_reordered.vcf
	WITH FRAMEWORK:		./Frameworks/GenomeAnalysisTK-3.5 : GenomeAnalysisTK.jar	-T IndelRealigner

7) Call variants
	DONE BY USING: 		./Scripts/muTectScript.sh
	REFERENCE FILE:		./ReferenceFiles/mm10.fa
	SNP FILE: 		./RefeferenceFiles/2012-0612-snps+indels_FVBNJ_annotated_reordered.vcf
	WITH FRAMEWORK:		./Frameworks/GenomeAnalysisTK-3.5 : GenomeAnalysisTK.jar	-T MuTect2

8) Annotate VCF
	DONE BY USING:		./Scripts/annotateWithSnpEff.sh
	REFERENCE:		GRCm38.82
	WITH FRAMEWORK:		./Frameworks/SnpEff/		:	snpEff.jar

9) Filter VCF
	DONE BY USING: 		./Scripts/SnpSiftForPass.sh
	WITH FRAMEWORK:		./Frameworks/SnpEff/		:	SnpSift.jar








If necessary:
Reorder BAM to reference file
	DONE BY USING:		./Scripts/reorderBamToReference.sh
	REFERENCE FILE:		./ReferenceFiles/mm10.fa
	WITH FRAMEWORK:		./Frameworks/Picard/	:	dist/picard.jar			-ReorderSam