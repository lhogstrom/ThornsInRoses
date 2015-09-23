#!/bin/sh

indir="/Users/hogstrom/Dropbox*(MIT)/imaging_data/20150617/tiling_series"

cd $indir
#ls $indir

n1=23b
n2=24

mv "MAP2_SYN1_SHANK3_${n1}_w2Conf 488.TIF" "MAP2_SYN1_SHANK3_${n2}_w2Conf 488.TIF"
mv "MAP2_SYN1_SHANK3_${n1}_w3Conf 561.TIF" "MAP2_SYN1_SHANK3_${n2}_w3Conf 561.TIF"
mv "MAP2_SYN1_SHANK3_${n1}_w4Conf 640.TIF" "MAP2_SYN1_SHANK3_${n2}_w4Conf 640.TIF"
mv "MAP2_SYN1_SHANK3_${n1}_w1Conf 405.TIF" "MAP2_SYN1_SHANK3_${n2}_w1Conf 405.TIF"

