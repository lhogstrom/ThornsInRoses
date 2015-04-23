# LH 2015

import numpy as np
from time import time

def nmf_mu(A,Winit,Hinit,timelimit,maxiter):
 """
 multiplicative algorithm to calculate nonnegative matrix
 factorization acording to Lee and Seung 2001
 """
 
 W = Winit; H = Hinit; initt = time();
 
 for i in range(maxiter):
    if time() - initt > timelimit: break
    H = H*(np.dot(W.T,A)) / (reduce(np.dot, [W.T, W, H]) + 1E-9)
    W = W*(np.dot(A,H.T)) / (reduce(np.dot, [W, H, H.T]) + 1E-9)
 
 return (W,H)