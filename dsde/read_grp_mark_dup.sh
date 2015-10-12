#!/bin/bash
use Samtools 

export picard=/seq/software/picard/current/bin/picard.jar
export outdir=/humgen/gsa-hpprojects/dev/hogstrom/depth_by_read_group


java -jar $picard MarkDuplicates \ 
INPUT=$outdir/NexPond-376014_chr21_rg_H23N7-1.bam \ 
OUTPUT=$outdir/NexPond-376014_chr21_rg_H23N7-1_dupMarked.bam \
METRICS_FILE=$outdir/NexPond-376014_chr21_rg_H23N7-1_dup_Metrics.txt

