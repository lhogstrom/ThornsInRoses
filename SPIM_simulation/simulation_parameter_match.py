# -*- coding: utf-8 -*-
# <nbformat>3.0</nbformat>

# <codecell>

from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from pylab import *
import Image

from tifffile import imsave
#%matplotlib inline

# <codecell>

def addBead(r,xf,yf,zf):
    '''
    r - sphere size
    xf - x offset 
    yf - y offset   
    zf - z offset     
    '''
    u = np.linspace(0, 2 * np.pi, 100)
    v = np.linspace(0, np.pi, 100)
    #construct bead
    x = r * np.outer(np.cos(u), np.sin(v)) + xf
    y = r * np.outer(np.sin(u), np.sin(v)) + yf
    z = r * np.outer(np.ones(np.size(u)), np.cos(v)) +zf
    return x, y, z

# <codecell>

def make_plane(xoff,yoff,zoff,normal,grid_range,ref_plane='z'):
    '''
    xoff - x offset 
    yoff - y offset
    zoff - z offset
    normal - define plane, eg: np.array([0, 0, 1])
    '''
    point  = np.array([0, 0, 0])
    # a plane is a*x+b*y+c*z+d=0
    # [a,b,c] is the normal. Thus, we have to calculate
    # d and we're set
    d = -point.dot(normal)
    ### x_ref
    if ref_plane =='x':
        # xy are the base grid
        z2, yy = np.meshgrid(grid_range, grid_range)
        xx = (-normal[2]*z2 - normal[1]*yy - d) * 1. /normal[0] # convert to real
    ### y_ref
    if ref_plane =='y':
        # xz are the base grid
        xx, z2 = np.meshgrid(grid_range, grid_range)
        yy = (-normal[0]*xx - normal[2]*z2 - d) * 1. /normal[1] # convert to real
    ### z_ref
    if ref_plane =='z':
        # xy are the base grid
        xx, yy = np.meshgrid(grid_range, grid_range)
        z2 = (-normal[0]*xx - normal[1]*yy - d) * 1. /normal[2] # convert to real
    #apply offset 
    xx = xx + xoff
    yy = yy + yoff
    zz = z2 + zoff
    return xx, yy, zz

# <markdowncell>

# ### Save multiplane tiff file to be loaded into Fiji ###

# <codecell>

wkdir = '/Users/hogstrom/Dropbox (MIT)/Neuron_data/SPIM_simulation/tiff'
beadSize = .05
nBeads = 40
bcMtrx = np.random.random_integers(-3,3,size=(nBeads,3)) #bead coordinate matrix
#a=-3
#b=3
#bcMtrx = (b - a) * np.random.random((3,3)) + a

fig = plt.figure() 
ax = fig.add_subplot(111, projection='3d')
# add multiple beads
x = np.zeros((0,100))
y = np.zeros((0,100))
z = np.zeros((0,100))
for i in range(nBeads):
    x1,y1,z1 = addBead(beadSize, bcMtrx[i,0], bcMtrx[i,1], bcMtrx[i,2])
    x = np.concatenate((x,x1))
    y = np.concatenate((y,y1))
    z = np.concatenate((z,z1))
    ax.plot_surface(x1, y1, z1,  rstride=4, cstride=4, color='b')
x1,y1,z1 = addBead(2, 0, 0, 0)
x = np.concatenate((x,x1))
y = np.concatenate((y,y1))
z = np.concatenate((z,z1))
ax.plot_surface(x1, y1, z1,  rstride=4, cstride=4, color='b')
show()
print bcMtrx

# <codecell>

#slice_thickness = .05
slice_thickness = 2
for j in [-3,-2,-1,0,1,2,3]:
    igr = bcMtrx[:,2] >= j
    ilt = bcMtrx[:,2] <= j + slice_thickness
    irange = igr * ilt
    #z[irange]
    fig = plt.figure(facecolor="k")
    ax = fig.add_subplot(1,1,1, axisbg="k")    
    ax.plot(bcMtrx[irange,0],bcMtrx[irange,1],'o',c='w') #, backgroundcolor='b'
    ax.axis([-4, 4, -4, 4])
    ax.set_axis_bgcolor('r')
    plt.axis('off')
    fname = wkdir + '/test_' + str(j) + '.tif'
    fig.savefig(fname,facecolor='k',dpi=200)
    show()
plt.close()

# <markdowncell>

# ### create tif images from matrix coordinates ### 

# <codecell>

def circle_around_coord(x,y,r,zero_grid):
    '''
    x - x position of center
    y - y position of center
    r - radius of circle around center
    zero_grid - matrix
    '''
    #(x-center_x)**2 + (y-center_y)**2 <= radius**2
    mtrx = zero_grid.copy()
    xAx = np.arange(zero_grid.shape[0])
    yAx = np.arange(zero_grid.shape[1])
    dx = np.abs(xAx - x)
    dy = np.abs(xAx - y)
    ### create matrix of euclidian distance form the point (x,y)
    eucMtrx = zero_grid.copy() 
    for ix in range(zero_grid.shape[0]):
        for iy in range(zero_grid.shape[0]):
            eucMtrx[ix,iy] = np.sqrt(dx[ix]**2 + dy[iy]**2)
    bCircle = eucMtrx < r # boolian matrix of the circle
    mtrx[bCircle] = 1
    return mtrx

# <codecell>

def circles_around_coord(xy,r,zero_grid):
    '''
    xy - numpy matrix of n bead coordinates (n x 2)
    r - radius of circle around center
    zero_grid - matrix
    '''
    #(x-center_x)**2 + (y-center_y)**2 <= radius**2
    mtrx = zero_grid.copy()
    xAx = np.arange(zero_grid.shape[0])
    yAx = np.arange(zero_grid.shape[1])
    for i in range(xy.shape[0]):
        x = xy[i,0]
        y = xy[i,1]
        dx = np.abs(xAx - x)
        dy = np.abs(xAx - y)
        ### create matrix of euclidian distance form the point (x,y)
        eucMtrx = zero_grid.copy() 
        for ix in range(zero_grid.shape[0]):
            for iy in range(zero_grid.shape[0]):
                eucMtrx[ix,iy] = np.sqrt(dx[ix]**2 + dy[iy]**2)
        bCircle = eucMtrx < r # boolian matrix of the circle
        mtrx[bCircle] = 1
    return mtrx

# <codecell>

### run circle coord
x=50
y=50
r=20
zero_grid = np.zeros((100,100))
crcMtrx = circle_around_coord(x,y,r,zero_grid) 
plt.imshow(crcMtrx)

### run circles coord
frmLarge = np.array([[710,   300], [284,   300]])
zero_grid = np.zeros((994,994))
r=10
crcMtrx = circles_around_coord(frmLarge,r,zero_grid) 
plt.imshow(crcMtrx)

# <markdowncell>

# ### write many tif images along multiple planes - multiframe tiff file ###

# <codecell>

slice_thickness = .05
nFrames = 7
boxMin = -3
boxMax = 3
spacing = (boxMax - boxMin + 1)/nFrames
steps = np.arange(boxMin,boxMax+1,spacing)
r=2 # pixel radius around bead center

mag = 1000/nFrames
npix = mag*nFrames
mtrx = np.zeros((nFrames,npix,npix))
for j in steps:
    igr = bcMtrx[:,2] >= j
    ilt = bcMtrx[:,2] <= j + slice_thickness
    irange = igr * ilt
    bcMtrx[irange,0]
    ### turn cooordinates into a matrix form
    frm = bcMtrx[irange,:2]
    frmLarge = frm*mag + (-boxMin * mag)
    mtrx[j,frmLarge[:,0],frmLarge[:,1]] = 1
    ### create a circles around the center of beads
    crcMtrx = circles_around_coord(frmLarge,r,zero_grid)
    mtrx[j,:,:] = crcMtrx
    plt.imshow(crcMtrx)
### write matrix to multiframe tiff
#image = np.zeros((32, 256, 256), 'uint16')
mtrx = np.array(mtrx, 'uint16')
fname = wkdir + '/test_multiframe.tif'
imsave(fname, mtrx)

# <markdowncell>

# ### store metadata for saved tiff images ###

# <codecell>

### write metadata
mtrx = np.array(mtrx, 'uint16')
fname = wkdir + '/test1_multiframe1.tif'
meatadata = 'ImageJ=1.49m\nimages=81\nslices=81\nunit=um\nspacing=2.0\nloop=false\n'
imsave(fname, mtrx, description=metadata)


### load metadata back in
import tifffile
with tifffile.TiffFile(fname) as tif:
    data = tif.asarray()
    metadata = tif[0].image_description

# <markdowncell>

# ### take 45 degree plane of 3D matrix ###

# <codecell>

mtrx = np.random.random_integers(-3,3,size=(10,10,10))
#45 degree angle hits the 
mtrx[:,0,-1]

# <markdowncell>

# ### 

