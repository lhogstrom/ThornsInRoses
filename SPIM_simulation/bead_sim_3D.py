from mpl_toolkits.mplot3d.axes3d import Axes3D
import matplotlib.pyplot as plt
from pylab import *
###
#from plotting tutorial 
#http://nbviewer.ipython.org/github/jrjohansson/scientific-python-lectures/blob/master/Lecture-4-Matplotlib.ipynb

alpha = 0.7
phi_ext = 2 * pi * 0.5

def flux_qubit_potential(phi_m, phi_p):
    return 2 + alpha - 2 * cos(phi_p)*cos(phi_m) - alpha * cos(phi_ext - 2*phi_p)
phi_m = linspace(0, 2*pi, 100)
phi_p = linspace(0, 2*pi, 100)
X,Y = meshgrid(phi_p, phi_m)
Z = flux_qubit_potential(X, Y).T


# fig = plt.figure(figsize=(14,6))

# # `ax` is a 3D-aware axis instance because of the projection='3d' keyword argument to add_subplot
# ax = fig.add_subplot(1, 2, 1, projection='3d')

# p = ax.plot_surface(X, Y, Z, rstride=4, cstride=4, linewidth=0)

# # surface_plot with color grading and color bar
# ax = fig.add_subplot(1, 2, 2, projection='3d')
# p = ax.plot_surface(X, Y, Z, rstride=1, cstride=1, cmap=cm.coolwarm, linewidth=0, antialiased=False)
# cb = fig.colorbar(p, shrink=0.5)


fig = plt.figure(figsize=(6,6))
# `ax` is a 3D-aware axis instance because of the projection='3d' keyword argument to add_subplot
ax = fig.add_subplot(1, 1, 1, projection='3d')
# p = ax.plot_surface(X, Y, Z, rstride=4, cstride=4, linewidth=0)
p = ax.plot_surface(X, Y, Z)
ax.view_init(0, 70)
plt.show()

x = np.random.random_integers(0,high=1,size=[10,10])
y = np.random.random_integers(0,high=1,size=[10,10])
z = np.random.random_integers(0,high=1,size=[10,10])

fig = plt.figure(figsize=(6,6))
# `ax` is a 3D-aware axis instance because of the projection='3d' keyword argument to add_subplot
ax = fig.add_subplot(1, 1, 1, projection='3d')
# p = ax.plot_surface(X, Y, Z, rstride=4, cstride=4, linewidth=0)
p = ax.plot_surface(x,y,z)
ax.view_init(0, 70)
plt.show()

