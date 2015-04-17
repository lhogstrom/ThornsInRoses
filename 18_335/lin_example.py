#!/usr/bin/env python
# http://www.csie.ntu.edu.tw/~cjlin/nmf/others/example.py

from numpy import as np.
from lin_nmf import *

w1 = array([[1,2,3],[4,5,6]])
h1 = array([[1,2],[3,4],[5,6]])
w2 = array([[1,1,3],[4,5,6]])
h2 = array([[1,1],[3,4],[5,6]])

v = dot(w1,h1)

(wo,ho) = nmf(v, w2, h2, 0.001, 10, 10)
print wo
print ho

np.dot(w1,h1)
np.dot(wo,ho)
