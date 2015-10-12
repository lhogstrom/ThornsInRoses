#!/bin/sh
# use Samtools

### write BAM index files to text
file1 = '/seq/picard_aggregation/G76270/NA12878/current/NA12878.bam'
outdir = '/humgen/gsa-hpprojects/dev/hogstrom/depth_by_read_group'

# view file according to read a single group number
#samtools view -r H01PE.3 $file1

# write file using specific read group ids
samtools view -bhR  $outdir/readgrp_ids.txt  file1 > $outdir/read_grp_test.bam

# randomly sample .1% of reads
samtools view -s .001 -hb1 /seq/picard_aggregation/D5227/NexPond-376014/current/NexPond-376014.bam > out_lines_001.bam

# run collect wgs metrics
java -jar /seq/software/picard/current/bin/picard.jar CollectWgsMetrics \
INPUT=out_lines_001.bam \
R=/seq/references/Homo_sapiens_assembly19/v1/Homo_sapiens_assembly19.fasta \
OUTPUT=out_lines_001.wgs_metrics

### write new bam file extracting specified region - WGS
​samtools view -hb /seq/picard_aggregation/G76270/NA12878/current/NA12878.bam 21 > /humgen/gsa-hpprojects/dev/hogstrom/depth_by_read_group/NA12878_chr21.bam
### write new bam file extracting specified region - Nexome
samtools view -hb /seq/picard_aggregation/D5227/NexPond-376014/current/NexPond-376014.bam 21 > /humgen/gsa-hpprojects/dev/hogstrom/depth_by_read_group/NexPond-376014_chr21.bam


### write new bam file using only specified read group




# picard example command
# java -jar /seq/software/picard/current/bin/picard.jar CollectRawWgsMetrics \
#  INPUT=/dev/stdin \
#  R=/seq/references/Homo_sapiens_assembly19/v1/Homo_sapiens_assembly19.fasta \
#  OUTPUT=Solexa-272222.p${PROB}.raw_wgs_metrics2
# view file according to read group number - 
samtools view -r H01PE.3 $file1
