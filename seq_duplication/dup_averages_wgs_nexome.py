import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

WGS = ['G69145', 'G71602', 'G71608', 'G76270']


### scatch import duplicate text files
# fname = "/seq/picard_aggregation/G69145/NA12878/current/NA12878.duplicate_metrics"
# gdup = pd.read_csv(fname,  "\t", skiprows=range(10), comment="#", names=['bin', 'val'])

### read in duplication metric details
metric_dict = {}
for wg in WGS:
    fname = "/seq/picard_aggregation/" + wg + "/NA12878/current/NA12878.duplicate_metrics"
    lines=list(csv.reader(open(fname))) 
    nMetrics = lines[6][0].split('\t')
    mvals = lines[7][0].split('\t')
    # read in depth info
    # fdepth = "/seq/picard_aggregation/" + wg + "/NA12878/current/NA12878.depthSM"
    metric_dict[wg] = mvals

# put into dataframe
df_wgs = pd.DataFrame.from_dict(metric_dict,orient='index')
df_wgs.columns = nMetrics
df_wgs['platform'] = 'WGS'

### insert size
metric_dict = {}
for wg in WGS:
    fname = "/seq/picard_aggregation/" + wg + "/NA12878/current/NA12878.insert_size_metrics"
    lines=list(csv.reader(open(fname))) 
    nMetrics = lines[6][0].split('\t')
    mvals = lines[7][0].split('\t')
    metric_dict[wg] = mvals

# put into dataframe
insert_wgs = pd.DataFrame.from_dict(metric_dict,orient='index')
insert_wgs.columns = nMetrics
insert_wgs['platform'] = 'WGS'



### Nexome dup data
NexomeIDs = ['359781',
 '359877',
 '360457',
 '361337',
 '388072',
 '381153',
 '364464',
 '377582',
 '384210',
 '384498',
 '372754',
 '386674',
 '393370',
 '385972',
 '373158',
 '379118',
 '385390',
 '391382',
 '383609',
 '386068',
 '383320',
 '383416',
 '382684',
 '392292',
 '376734',
 '376014']

metric_dict = {}
for nx in NexomeIDs:
    fname = "/seq/picard_aggregation/D5227/NexPond-" + nx + "/current/NexPond-" + nx + ".duplicate_metrics"
    lines=list(csv.reader(open(fname))) 
    nMetrics = lines[6][0].split('\t')
    mvals = lines[7][0].split('\t')
    metric_dict[nx] = mvals

# put into dataframe
df_nex = pd.DataFrame.from_dict(metric_dict,orient='index')
df_nex.columns = nMetrics
df_nex['platform'] = 'Nexome'

#concoatonate wgs and nexome
frames = [df_wgs, df_nex]
df_merge = pd.concat(frames)

fout = '/home/unix/hogstrom/nexpond_wgs_dup_metrics.txt'
df_merge.to_csv(fout)


### read in locally
import matplotlib.pyplot as plt
import pandas as pd

fin = "/Users/hogstrom/Dropbox (MIT)/genome_analysis/published_data/nexpond_wgs_dup_metrics.txt"
g = pd.read_csv(fin,index_col=0)

g.boxplot('ESTIMATED_LIBRARY_SIZE', by='platform')
g.boxplot('PERCENT_DUPLICATION', by='platform')
g.boxplot('READ_PAIR_DUPLICATES', by='platform')


# plt.plot(g['ESTIMATED_LIBRARY_SIZE'].values,g['PERCENT_DUPLICATION'].values)