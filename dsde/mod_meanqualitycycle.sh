#!/bin/bash
## shell script to run modified MeanQualityByCycle locally

picard=/Users/larsonhogstrom/Documents/code/ThornsInRoses/dsde/mod_meanqualitycycle.sh
wkdir="/Users/larsonhogstrom/Dropbox (MIT)/genomic_library_complexity"


### run picard
java -jar $picard MeanQualityByCycle \
     INPUT=$wkdir/test_chrm21_rg2.bam \
     OUTPUT=$wkdir/out_MeanQualityByCycle.txt \
     CHART_OUTPUT=$wkdir/out_MeanQualityByCycle.pdf
