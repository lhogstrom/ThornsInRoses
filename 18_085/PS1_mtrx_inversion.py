import numpy as np


n = 5
mtrx = np.diag(np.repeat(2,n),k=0)
off1 = np.diag(np.repeat(-1,n-1),k=1)
off2 = np.diag(np.repeat(-1,n-1),k=-1)
mtrx = mtrx + off1 + off2

mtrx_inv = np.linalg.inv(mtrx)
colsum = mtrx_inv[:,0].sum()

form1 = mtrx_inv * np.linalg.det(mtrx)