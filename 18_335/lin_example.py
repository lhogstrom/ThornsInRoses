#!/usr/bin/env python
# http://www.csie.ntu.edu.tw/~cjlin/nmf/others/example.py

import numpy as np
from lin_nmf import *
import matplotlib.pyplot as plt 
from nmf_multiplicative_update import *
from time import time

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

#backward-like stability measure
np.dot(w1,h1) - np.dot(wo,ho)

### second example
n=5 # size of square matrix
n_iter = 40
#meanVec = np.zeros((n_iter,1))
meanVec = np.zeros((1,n_iter))
for m in range(n_iter):
    w1 = np.random.rand(m,n)
    h1 = np.random.rand(n,m)
    v = np.dot(w1,h1)
    #nmf decomposition of v
    (wo,ho) = nmf(v, np.random.rand(m,n), np.random.rand(n,m), 0.001, 10, 10)
    #backward-like stability measure
    diffMtrx = np.dot(w1,h1) - np.dot(wo,ho)
    meanVec[0,m] = diffMtrx.mean()
#plot changes in error 
plt.plot(range(n_iter),meanVec[0])


### draft of NMF alg
max_iter = 100
A = np.dot(w1,h1)
W = np.random.rand(m,n)
H = np.random.rand(n,m)
for i in range(max_iter):
    H = H*(np.dot(W.T,A)) / (reduce(np.dot, [W.T, W, H]) + 1E-9)
    W = W*(np.dot(A,H.T)) / (reduce(np.dot, [W, H, H.T]) + 1E-9)
A - np.dot(W,H)

Winit = np.random.rand(m,n)
Hinit = np.random.rand(n,m)
(W,H) = nmf_mu(A,Winit,Hinit,5,100)
A - np.dot(W,H)

### plot error from matrix of increasing size
a = [ pow(2,i) for i in range(12) ]
meanVec = np.zeros((2,len(a)))
for i,m in enumerate(a):
    print m 
    w1 = np.random.rand(m,n)
    h1 = np.random.rand(n,m)
    v = np.dot(w1,h1)
    #nmf decomposition of v:
    #multiplicative update
    (wo,ho) = nmf_mu(v,np.random.rand(m,n), np.random.rand(n,m),5,100)
    # projection gradient
    (w_pg,h_pg) = nmf(v, np.random.rand(m,n), np.random.rand(n,m), 0.001, 10, 10)
    #backward-like stability measure
    diffMtrx = np.dot(w1,h1) - np.dot(wo,ho)
    diffMtrx2 = np.dot(w1,h1) - np.dot(w_pg,h_pg)
    meanVec[0,i] = diffMtrx.mean()
    meanVec[1,i] = diffMtrx2.mean()
#plot changes in error 
# plt.plot(a,meanVec[0])
fig = plt.figure()
ax = fig.add_subplot(1,1,1)
plt.plot(a,meanVec[0,:],color='b',label='multiplicative_update')
plt.plot(a,meanVec[1,:],color='r',label='gradient_projection')
ax.set_xscale('log')
plt.title('NMF entry error')
plt.xlabel('matrix length')
plt.ylabel('mean error')
plt.legend(loc=2)
plt.show()

### convergence with increased iteration 
a = [ pow(2,i) for i in range(13) ]
m = 500
n = 5
meanVec = np.zeros((1,len(a)))
for i,m in enumerate(a):
    print m 
    w1 = np.random.rand(m,n)
    h1 = np.random.rand(n,m)
    v = np.dot(w1,h1)
    #nmf decomposition of v:
    #multiplicative update
    (wo,ho) = nmf_mu(v,np.random.rand(m,n), np.random.rand(n,m),5,m)
    # projection gradient
    #backward-like stability measure
    diffMtrx = np.dot(w1,h1) - np.dot(wo,ho)
    diffMtrx = np.dot(w1,h1) - np.dot(wo,ho)
    meanVec[0,i] = diffMtrx.mean()
fig = plt.figure()
ax = fig.add_subplot(1,1,1)
plt.plot(a,meanVec[0,:],color='b',label='multiplicative_update')
ax.set_xscale('log')
plt.title('NMF entry error')
plt.xlabel('n iterations')
plt.ylabel('mean error')
plt.legend(loc=2)
plt.show()

### time used by matrix size n 
a = [ pow(2,i) for i in range(13) ]
meanVec = np.zeros((1,len(a)))
for i,m in enumerate(a):
    print m 
    w1 = np.random.rand(m,n)
    h1 = np.random.rand(n,m)
    v = np.dot(w1,h1)
    #nmf decomposition of v:
    #multiplicative update
    initt = time()
    (wo,ho) = nmf_mu(v,np.random.rand(m,n), np.random.rand(n,m),5,100)
    tafter = time() - initt
    meanVec[0,i] = tafter
#plot changes in error 
# plt.plot(a,meanVec[0])
fig = plt.figure()
ax = fig.add_subplot(1,1,1)
plt.plot(a,meanVec[0,:],color='b',label='multiplicative_update')
ax.set_xscale('log')
ax.set_yscale('log')
plt.title('NMF entry error')
plt.xlabel('seconds')
plt.ylabel('mean error')
plt.legend(loc=2)
plt.show()

### scratch for Alternative Least Squares (ALS) method
max_iter = 100
A = np.dot(w1,h1)
W = np.random.rand(m,n)
H = np.random.rand(n,m)
for i in range(max_iter):
    H = H*(np.dot(W.T,A)) / (reduce(np.dot, [W.T, W, H]) + 1E-9)
    W = W*(np.dot(A,H.T)) / (reduce(np.dot, [W, H, H.T]) + 1E-9)
A - np.dot(W,H)


## numpy solve test
m = 5
n = 3
A = np.random.rand(m,n)
b = np.random.random(m)
B = np.random.rand(m,n)

x = np.linalg.lstsq(A,B)
X = x[0]

np.dot(A,x[0]) - B

# set nonnegative values to zeros
X_is_neg = X < 0
X[X_is_neg] = 0