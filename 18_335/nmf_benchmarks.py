#!/usr/bin/env python

import numpy as np
from lin_nmf import *
import matplotlib.pyplot as plt 
import nmf_multiplicative_update as nmflh
from time import time
import os

wkdir = '/Users/hogstrom/Dropbox (Personal)/cources_spring_2015_MIT/18_335_Numeric_Methods/NMF/figures'

n=5
### plot error from matrix of increasing size
a = [ pow(2,i) for i in range(13) ]
meanVec = np.zeros((2,len(a)))
for i,m in enumerate(a):
    print m 
    w1 = np.random.rand(m,n)
    h1 = np.random.rand(n,m)
    v = np.dot(w1,h1)
    #nmf decomposition of v:
    #multiplicative update
    (wo,ho) = nmflh.nmf_mu(v,np.random.rand(m,n), np.random.rand(n,m),5,100)
    # projection gradient
    (w_pg,h_pg) = nmf(v, np.random.rand(m,n), np.random.rand(n,m), 0.001, 10, 10)
    #backward-like stability measure
    diffMtrx = np.dot(w1,h1) - np.dot(wo,ho)
    diffMtrx2 = np.dot(w1,h1) - np.dot(w_pg,h_pg)
    meanVec[0,i] = diffMtrx.mean()
    meanVec[1,i] = diffMtrx2.mean()
#plot changes in error 
fig = plt.figure()
ax = fig.add_subplot(1,1,1)
plt.plot(a,meanVec[0,:],color='b',label='multiplicative_update')
plt.plot(a,meanVec[1,:],'r--',label='gradient_projection')
ax.set_xscale('log')
plt.title('NMF entry error')
plt.xlabel('matrix length')
plt.ylabel('mean error')
plt.legend(loc=2)
outFile = os.path.join(wkdir, 'projection_gradient_vs_multiplicative_update_error.png')
plt.savefig(outFile)
plt.close()

### convergence with increased iteration 
a = [ pow(2,i) for i in range(13) ]
m = 500
n = 5
meanVec = np.zeros((1,len(a)))
for i,j in enumerate(a):
    print m 
    w1 = np.random.rand(m,n)
    h1 = np.random.rand(n,m)
    v = np.dot(w1,h1)
    #nmf decomposition of v:
    #multiplicative update
    (wo,ho) = nmflh.nmf_mu(v,np.random.rand(m,n), np.random.rand(n,m),5,j)
    # projection gradient
    #backward-like stability measure
    diffMtrx = np.dot(w1,h1) - np.dot(wo,ho)
    meanVec[0,i] = diffMtrx.mean()
fig = plt.figure()
ax = fig.add_subplot(1,1,1)
plt.plot(a,meanVec[0,:],color='b',label='multiplicative_update')
ax.set_xscale('log')
plt.title('NMF entry error')
plt.xlabel('n iterations')
plt.ylabel('mean error of entries')
plt.legend(loc=2)
outFile = os.path.join(wkdir, 'multiplicative_update_iteration_error.png')
plt.savefig(outFile)
plt.close()


### ALS vs multiplicative update - convergence with increased iteration - 
a = [ pow(2,i) for i in range(11) ]
m = 500
n = 5
meanVec = np.zeros((2,len(a)))
for i,j in enumerate(a):
    print j 
    w1 = np.random.rand(m,n)
    h1 = np.random.rand(n,m)
    v = np.dot(w1,h1)
    #nmf decomposition of v:
    #multiplicative update
    (wo,ho) = nmflh.nmf_mu(v,np.random.rand(m,n), np.random.rand(n,m),5,j)
    # ALS method
    (w_als,h_als) = nmflh.nmf_ALS(v, np.random.rand(m,n), np.random.rand(n,m),5,j)
    #backward-like stability measure
    diffMtrx = np.dot(w1,h1) - np.dot(wo,ho)
    diffMtrx2 = np.dot(w1,h1) - np.dot(w_als,h_als)
    # residual norm
    meanVec[0,i] = np.linalg.norm(diffMtrx, ord=None) #Frobenius norm
    meanVec[1,i] = np.linalg.norm(diffMtrx2, ord=None) #Frobenius norm
fig = plt.figure()
ax = fig.add_subplot(1,1,1)
plt.plot(a,meanVec[0,:],color='b',label='multiplicative update')
plt.plot(a,meanVec[1,:],'r--',label='ALS method')
ax.set_xscale('log')
ax.set_yscale('log')
plt.title('NMF iteration')
plt.xlabel('n iteration')
plt.ylabel('norm residual')
plt.legend(loc=7)
outFile = os.path.join(wkdir, 'ALS_vs_multiplicative_update_iteration_error.png')
plt.savefig(outFile)
plt.close()

### time used by matrix size n 
a = [ pow(2,i) for i in range(15) ]
meanVec = np.zeros((1,len(a)))
for i,m in enumerate(a):
    print m 
    w1 = np.random.rand(m,n)
    h1 = np.random.rand(n,m)
    v = np.dot(w1,h1)
    #nmf decomposition of v:
    #multiplicative update
    initt = time()
    (wo,ho) = nmflh.nmf_mu(v,np.random.rand(m,n), np.random.rand(n,m),5,100)
    tafter = time() - initt
    meanVec[0,i] = tafter
#plot
fig = plt.figure()
ax = fig.add_subplot(1,1,1)
plt.plot(a,meanVec[0,:],color='b',label='multiplicative_update')
ax.set_xscale('log')
ax.set_yscale('log')
plt.title('NMF decomposition into 5 components')
plt.xlabel('matrix size n')
plt.ylabel('seconds')
plt.legend(loc=2)
outFile = os.path.join(wkdir, 'multiplicative_update_time.png')
plt.savefig(outFile)
plt.close()

### ACLS - sparcity constraints - ERROR
a = [ pow(2,i) for i in range(11) ]
meanVec = np.zeros((2,len(a)))
for i,j in enumerate(a):
    print j
    w1 = np.random.rand(m,n)
    h1 = np.random.rand(n,m)
    v = np.dot(w1,h1)
    #nmf decomposition of v:
    # ALS method
    Winit = np.random.rand(m,n)
    Hinit =np.random.rand(n,m)
    lw = 2
    lh = 2
    (w_acls,h_acls) = nmflh.nmf_ACLS(v, Winit, Hinit,lh,lw,5,j)
    # ACLS method
    (w_als,h_als) = nmflh.nmf_ALS(v, Winit, Hinit,5,j)
    #backward-like stability measure
    diffMtrx = np.dot(w1,h1) - np.dot(w_als,h_als)
    diffMtrx2 = np.dot(w1,h1) - np.dot(w_acls,h_acls)
    # residual norm
    meanVec[0,i] = np.linalg.norm(diffMtrx, ord=None) #Frobenius norm
    meanVec[1,i] = np.linalg.norm(diffMtrx2, ord=None) #Frobenius norm
# plot
fig = plt.figure()
ax = fig.add_subplot(1,1,1)
plt.plot(a,meanVec[0,:],color='b',label='ALS method')
plt.plot(a,meanVec[1,:],'r--',label='ACLS method')
ax.set_xscale('log')
ax.set_yscale('log')
plt.title('NMF iteration')
plt.xlabel('n iteration')
plt.ylabel('norm residual')
plt.legend(loc=7)
outFile = os.path.join(wkdir, 'ALS_vs_ACLS_error.png')
plt.savefig(outFile)
plt.close()

#sparcity measure 
def percent_nearzero(M,thresh):
    n_entries = M.shape[0]*M.shape[1]
    above_nearzero = M > thresh
    pnz = above_nearzero.sum()/ np.float(n_entries) #percent_nearzero
    return pnz
### ACLS - sparsity constraints - Sparsity
a = [ pow(2,i) for i in range(15) ]
a = np.array(a)/100.0
meanVec = np.zeros((2,len(a)))
for i,lw in enumerate(a):
    print lw
    w1 = np.random.rand(m,n)
    h1 = np.random.rand(n,m)
    v = np.dot(w1,h1)
    #nmf decomposition of v:
    # ALS method
    Winit = np.random.rand(m,n)
    Hinit =np.random.rand(n,m)
    lh = lw
    j = 10 #n_iter
    # ACLS method
    (w_acls,h_acls) = nmflh.nmf_ACLS(v, Winit, Hinit,lh,lw,5,j)
    # AHCLS method
    # (w_acls,h_acls) = nmflh.nmf_AHCLS(v, Winit, Hinit,lh,lw,.5,.5,5,j)
    # ALS method
    (w_als,h_als) = nmflh.nmf_ALS(v, Winit, Hinit,5,j)
    #backward-like stability measure
    near_zero_thresh = .0001
    # percent_nearzero(h_als,near_zero_thresh)
    # percent_nearzero(h_acls,near_zero_thresh)
    # residual norm
    meanVec[0,i] = percent_nearzero(w_als,near_zero_thresh)
    meanVec[1,i] = percent_nearzero(w_acls,near_zero_thresh)
# plot
fig = plt.figure()
ax = fig.add_subplot(1,1,1)
plt.plot(a,meanVec[0,:],color='b',label='ALS method')
plt.plot(a,meanVec[1,:],'r--',label='ACLS method')
ax.set_xscale('log')
plt.title('Sparsity of W matrix')
plt.xlabel('lambda')
plt.ylabel('fraction of nearzero entries')
plt.legend(loc=7)
outFile = os.path.join(wkdir, 'ALS_vs_ACLS_sparsity.png')
plt.savefig(outFile)
plt.close()

