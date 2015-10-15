#!/bin/bash
#use Samtools 

picard=/seq/software/picard/current/bin/picard.jar
outdir=/humgen/gsa-hpprojects/dev/hogstrom/depth_by_read_group/376014
bamdir=/seq/picard_aggregation/D5227/NexPond-376014/current #nexome

# use bed file to specify chromosome 
# samtools view -h $bamdir/NexPond-376014.bam \
#     -L $outdir/chrm21_full.bed \
#     -o $outdir/NexPond-376014_chrm21.bam
 
### isolate specific read groups  
# for i in {1..9}; do 

#     echo "read group set "$i
#     samtools view -h $outdir/NexPond-376014_chrm21.bam \
#         -R $outdir/read_grp_list$i.txt \
#         -o $outdir/NexPond-376014_chrm21_rg$i.bam

# done

### mark duplicates for each read group sets
for i in {1..9}; do 

    echo "read group set "$i
    java -jar $picard MarkDuplicates \
        INPUT=$outdir/NexPond-376014_chrm21_rg${i}.bam \
        OUTPUT=$outdir/NexPond-376014_chrm21_rg${i}_dupMarked.bam \
        METRICS_FILE=$outdir/NexPond-376014_chrm21_rg${i}_dup_Metrics.txt

done




### run SortSam 
# java -jar $picard SortSam \
#     INPUT=$outdir/NexPond-376014_chr21_rg_H23N7-1.bam \
#     OUTPUT=$outdir/NexPond-376014_chr21_rg_H23N7-1_sorted.bam \
#     SORT_ORDER=coordinate 


# java -jar $picard MarkDuplicates \
#     INPUT=$outdir/NexPond-376014_chrm21_H23N71.bam \
#     OUTPUT=$outdir/NexPond-376014_chrm21_H23N71_dupMarked.bam \
#     METRICS_FILE=$outdir/NexPond-376014_chrm21_H23N71_dup_Metrics.txt