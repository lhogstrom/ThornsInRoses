import tifffile
import json
import pandas as pd
'''
load metadata for Fame's tiff converted SPIM file
'''

tifFile = '/home/lcbb/Documents/Larson/Data/Fame_SPIM/spim_TL1_Angle280.tif'
with tifffile.TiffFile(tifFile) as tif:
    data = tif.asarray()
    metadata = tif[0].image_description
#metadata = json.loads(metadata.decode('utf-8'))

### obtain image tags
g = tif[0]
Tags = g.imagej_tags
Tags['slices']
tagInfo = Tags['info']
tagSplit = tagInfo.split('\n')

#write image tags to a table
tableOut = '/home/lcbb/Documents/Larson/Data/Fame_SPIM/metadata_table_TL1_Angle280.txt'
metaTbl = pd.DataFrame(tagSplit)
metaTbl.to_csv(tableOut,sep='\t')

