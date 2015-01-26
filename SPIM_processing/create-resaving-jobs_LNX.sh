#!/bin/bash
dir="/home/lcbb/Documents/Larson/Data/Fame_SPIM"
jobs="$dir/jobs/resaving"
 
mkdir -p $jobs
 
#for i in `seq 1 240`
for i in `seq 1 1`
do
    job="$jobs/resave-$i.job"
        echo $job
        echo "#!/bin/bash" > "$job"
        echo "xvfb-run -a /home/lcbb/Documents/Larson/fiji/Fiji.app/ImageJ-linux64 \
             -Ddir=$dir -Dtimepoint=$i -Dangle=280 \
             -- --no-splash ${jobs}/resaving.bsh" >> "$job"
        chmod a+x "$job"
done


# for i in `seq 1 6`
# do
#     job="$jobs/resave-$i.job"
#         echo $job
#         echo "#!/bin/bash" > "$job"
#         echo "xvfb-run -a /sw/users/tomancak/packages/Fiji.app/ImageJ-linux64 \
# -Ddir=$dir -Dtimepoint=$i -Dangle=280 \
# -- --no-splash ${jobs}/resaving.bsh" >> "$job"
#         chmod a+x "$job"
# done
