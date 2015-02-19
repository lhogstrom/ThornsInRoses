%% Class 3: 
% Alex Townsend, 12th Feb 2015
%        ajt@mit.edu

%% LU decomposition 
A = randn( 100 ); A = A'*A + eye( 100 ) ; 
spy( A ) 

%% 
[L, U] = lu( A ); 
subplot(1,2,1) 
spy( L ), title('Unit lower triangular','fontsize',16)
subplot(1,2,2) 
spy( U ), title('Upper triangular','fontsize',16)

%% Elimination computes A = LU: 
K3 = [2 -1 0 ; -1 2 -1; 0 -1 2];
[L, U] = lu( K3 ); 

%% Used to solve linear systems: 
b = randn( 3, 1); 
exact = K3 \ b;

%% Lower triangular linear systems: Solve by forwards substitution
y = zeros( 3, 1); 
for k = 1:3
    y(k) = (b(k) - L(k,1:k-1)*y(1:k-1))/L(k,k);
end

%% Upper-triangular linear systems: Solve by backwards substitution
x = zeros( 3, 1); 
for k = 3:-1:1
    x(k) = (y(k) - U(k,k+1:end)*x(k+1:end))/U(k,k);
end

%% LU has a problem (in principle): 
n = 5;    % Try 1025
Wn = tril(-ones( n ),-1) + eye( n ); Wn(:,n) = 1;  

[L, U] = lu( Wn );
U
U(n,n)

% No solution to this problem. 
% However, in practice this type of growth is never seen. And I mean never.
% If you do meet a matrix like this in practice call 
% an ambulance, you are about to be
% stuck by three bolts of lightening simutaneously. 

%% LU has another problem (it does not always exist)? 
% Consider A = [0 1 ; 1 0]. 

%% Solution!  Pivoting.   
% In practice pivoting happens all the time. 

A = randn( 100 ); 
[L, U] = lu( A ); 
subplot(1,2,1) 
spy( L )   % row pivoting is in L!!! 
subplot(1,2,2) 
spy( U ) 

%% A third argument in lu shows you the pivoting: 

[L, U, P] = lu( A ); 

[L, U] = lu( A ); 
subplot(1,2,1) 
spy( L )   % row pivoting is in L!!! 
subplot(1,2,2) 
spy( U ) 

%% Now a decomposition of PA...
norm( A - L*U )   % large 
norm( P*A - L*U ) % decomposition of PA, not A 





