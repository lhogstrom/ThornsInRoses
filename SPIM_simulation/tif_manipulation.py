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