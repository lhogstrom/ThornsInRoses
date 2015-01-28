import tifffile
import json
import pandas as pd
import numpy as np

from tifffile import imsave
'''
load metadata for Fame's tiff converted SPIM file
'''

tifFile = '/Users/hogstrom/Dropbox (MIT)/Neuron_data/spim_TL18_Angle0.tif'
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
tableOut = '/Users/hogstrom/Dropbox (MIT)/Neuron_data/spim_TL18_Angle0_metadata.txt'
metaTbl = pd.DataFrame(tagSplit)
metaTbl.to_csv(tableOut,sep='\t')

### write metadata with mask image
wkdir = '/Users/hogstrom/Dropbox (MIT)/Neuron_data/SPIM_simulation/tiff'
npix = 994
mtrx = np.zeros((30,npix,npix))

mtrx = np.array(mtrx, 'uint16')
fname = wkdir + '/test1_multiframe_OpenSpim_1.tif'
#metadata = 'ImageJ=1.49m\nimages=81\nslices=81\nunit=um\nspacing=2.0\nloop=false\n'
imsave(fname, mtrx, description=tagInfo)


### load the new file back in again
with tifffile.TiffFile(fname) as tif2:
    data = tif2.asarray()

### get meta 
# from PIL import Image
# im = Image.open(tifFile)
# exif_data = im.info['exif']
