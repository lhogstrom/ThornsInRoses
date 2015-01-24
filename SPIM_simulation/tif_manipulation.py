from PIL import Image

####
#### Scratch code to import multiframe tif files #####
####


### load tif in 
tifFile = '/Users/hogstrom/Dropbox (MIT)/Neuron_data/spim_TL18_Angle0.tif'
im = Image.open(tifFile)
im.show()


from skimage import data_dir
img = skimage.io.MultiImage(data_dir + '/multipage.tif') 
skimage.io.imsave(fout, img)

import numpy as np
from tifffile import imsave
image = np.zeros((32, 256, 256), 'uint16')
imsave('multipage.tif', image)

from tifffile import imread
image = imread(tifFile)



### write tif out
#from skimage.io._plugins import freeimage_plugin as fi
import skimage
fout = '/Users/hogstrom/Dropbox (MIT)/Neuron_data/SPIM_simulation/tiff/multiframe_test.tif'
image = np.zeros((32, 256, 256), 'uint16')
# fi.write_multipage(image, 'multipage.tif')
# I = skimage.io.Image(image)
skimage.io.imsave(fout, image)

from skimage import data_dir
img = MultiImage(data_dir + '/multipage.tif') 


## 
import numpy as np
from tifffile import imsave
image = np.zeros((32, 256, 256), 'uint16')
imsave('multipage.tif', image)


### load metadata
import json
import numpy
import tifffile  # http://www.lfd.uci.edu/~gohlke/code/tifffile.py.html

metaFile = '/Users/hogstrom/Dropbox (MIT)/Neuron_data/SPIM_simulation/tiff/meatadata_test.tif'
data = numpy.arange(256).reshape((16, 16)).astype('u1')
#metadata = dict(microscope='george', shape=data.shape, dtype=data.dtype.str)
metadata = 'hi'
#print(data.shape, data.dtype, metadata['microscope'])

#metadata = json.dumps(metadata)
tifffile.imsave(metaFile, data, description=metadata)

with tifffile.TiffFile(metaFile) as tif:
    data = tif.asarray()
    metadata = tif[0].image_description
metadata = json.loads(metadata.decode('utf-8'))
print(data.shape, data.dtype, metadata['microscope'])






import tifffile
tifFile = '/Users/hogstrom/Dropbox (MIT)/Neuron_data/spim_TL18_Angle0.tif'
with tifffile.TiffFile(tifFile) as tif:
    data = tif.asarray()
    metadata = tif[0].image_description
metadata = json.loads(metadata.decode('utf-8'))
