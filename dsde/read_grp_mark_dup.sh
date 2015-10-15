#!/bin/bash
#use Samtools 

picard=/seq/software/picard/current/bin/picard.jar
outdir=/humgen/gsa-hpprojects/dev/hogstrom/depth_by_read_group
bamdir=/seq/picard_aggregation/G76270/NA12878/current/ #wgs
#bamdir=/seq/picard_aggregation/D5227/NexPond-376014/current #nexome

###
# use bed file to specify chromosome 
###

# WGS
samtools view -h $bamdir/NA12878.bam \
    -L $outdir/chrm21_full.bed \
    -r H01PE.3 \
    -o $outdir/NA12878_chrm21_H01PE3.bam

# Nexome
# samtools view -h $bamdir/NexPond-376014.bam \
#     -L $outdir/chrm21_full.bed \
#     -r H23N7.1 \
#     -o $outdir/NexPond-376014_chrm21_H23N71.bam

# samtools view -hb /NexPond-376014.bam 21 > /humgen/gsa-hpprojects/dev/hogstrom/depth_by_read_group/NexPond-376014_chr21.bam
 

### run SortSam 
# java -jar $picard SortSam \
#     INPUT=$outdir/NexPond-376014_chr21_rg_H23N7-1.bam \
#     OUTPUT=$outdir/NexPond-376014_chr21_rg_H23N7-1_sorted.bam \
#     SORT_ORDER=coordinate 


# java -jar $picard MarkDuplicates \
#     INPUT=$outdir/NexPond-376014_chrm21_H23N71.bam \
#     OUTPUT=$outdir/NexPond-376014_chrm21_H23N71_dupMarked.bam \
#     METRICS_FILE=$outdir/NexPond-376014_chrm21_H23N71_dup_Metrics.txt