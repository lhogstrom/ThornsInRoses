%% Class 9: 
% Alex Townsend, 12th March 2015
%        ajt@mit.edu


%% Question from last class: Is V^TU = identity? 

%% Rectangular matrix: 
A = randn( 3, 2 ); 
[U, S, V] = svd( A ) ; 
V'*U 

%% Square matrix: 
A = randn( 3 ); 
[U, S, V] = svd( A ) ; 
V'*U 

%% Symmetric square matrix: 
A = randn( 3 ); 
A = (A + A')/2; 
[U, S, V] = svd( A ) ; 
V'*U 

%% Three matrices
K2 = [1 -.5; -.5 1]; 
B2 = [1 -1; -1 1]; 
M2 = [1 -3; -3 1];

K2, B2, M2

%% TEST: Positive definite matrices have positive eigenvalues 

K2_eig = eig(K2)
B2_eig = eig(B2)
M2_eig = eig(M2)

%% TEST: Positive definite matrices are connected to quadratic 
% forms that have +ve 2nd derivative
[x1, x2] = meshgrid( linspace(-10,10) ); 
surf(x1, x2, x1.^2 - x1.*x2 + x2.^2, 'edgealpha', 0 ) 
title('K_2','fontsize',16)

%% 
[x1, x2] = meshgrid( linspace(-10,10) ); 
surf(x1, x2, x1.^2 - 2*x1.*x2 + x2.^2, 'edgealpha', 0 ) 
title('B_2','fontsize',16)

%% 
[x1, x2] = meshgrid( linspace(-10,10) ); 
surf(x1, x2, x1.^2 - 6*x1.*x2 + x2.^2, 'edgealpha', 0 ) 
title('M_2','fontsize',16)

%% TEST: Positive definite matrices have a Cholesky factorization: 

chol( K2 ) 

chol( B2 ) 

chol( M2 ) 

%% Remaining questions from the class 1-10: 

%% Does every symmetric matrix have an LDL^T? No. But close... 

A = randn( 3 ); A = (A + A')/2; 
[L, D] = ldl( A )


%% How to compute the SVD in practice. Use MATLAB: 
A = randn( 3 ); 
[U, S, V] = svd( A )

%% Gerschgorin's circle, can eigenvalues be on the edge of the circle? 
% Yes. 
A = [0 -1; 1 0]; 
t = linspace(0,2*pi); 
plot( exp(1i*t), 'k-','linewidth',2), hold on, 
plot( eig( A )+eps*1i, 'r.', 'markersize', 30)
axis equal 
set(gca,'fontsize', 16)
