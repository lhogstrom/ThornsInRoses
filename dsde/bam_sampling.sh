#!/bin/sh

### write BAM index files to text
file1 = '/seq/picard_aggregation/G76270/NA12878/current/NA12878.bam'

# view file according to read group number - 
samtools view -r H01PE.3 $file1