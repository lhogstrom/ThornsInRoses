# LH 2015

import numpy as np
from time import time
from lin_nmf import *

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

def nmf_gd(A,Winit,Hinit,timelimit,maxiter,stepsize):
   """
   gradient descent algorithm to calculate nonnegative matrix
   factorization 
   """
   W = Winit; H = Hinit; initt = time();
   
   # gradients from Lin's projection code:
   #gradW = dot(W, dot(H, H.T)) - dot(A, H.T)
   #gradH = dot(dot(W.T, W), H) - dot(W.T, A)

   # Gradients from Johnson
   gradW = dot(W, dot(H, H.T)) - dot(A, H.T)
   gradH = dot(dot(W.T, W), H) - dot(W.T, A)

   for i in range(maxiter):
      if time() - initt > timelimit: break
      H = H - stepsize*gradH
      W = W - stepsize*gradW
   
      gradW = dot(W, dot(H, H.T)) - dot(A, H.T)
      gradH = dot(dot(W.T, W), H) - dot(W.T, A)

   return (W,H)

def nmf_ALS(A,Winit,Hinit,timelimit,maxiter):
 """
 alternating least squares method to calculate nonnegative matrix
 factorization acording to Patero 2004 / Langville 2006
 """
 
 W = Winit; H = Hinit; initt = time();
 
 for i in range(maxiter):
    if time() - initt > timelimit: break
    H = np.linag.



    H = H*(np.dot(W.T,A)) / (reduce(np.dot, [W.T, W, H]) + 1E-9)
    W = W*(np.dot(A,H.T)) / (reduce(np.dot, [W, H, H.T]) + 1E-9)
 
 return (W,H)   