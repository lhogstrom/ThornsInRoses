#!/bin/sh
# test preseq usage

### preseq with BAM file - with randomly sampled lines
/humgen/gsa-hpprojects/dev/hogstrom/code/preseq/preseq lc_extrap -B -o /humgen/gsa-hpprojects/dev/hogstrom/depth_by_read_group/yield_estimates.txt /humgen/gsa-hpprojects/dev/hogstrom/depth_by_read_group/out_lines_0001.bam

# run preseq on full WGS data
/humgen/gsa-hpprojects/dev/hogstrom/code/preseq/preseq lc_extrap -B -o /humgen/gsa-hpprojects/dev/hogstrom/depth_by_read_group/NA12878_yield_estimates.txt /seq/picard_aggregation/G76270/NA12878/current/NA12878.bam

