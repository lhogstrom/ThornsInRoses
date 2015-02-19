%% Class 1: 
% Alex Townsend, 3rd Feb 2015
%        ajt@mit.edu

%% Numerical versus symbolic
f = @(x) exp(-x).*cos(6*x).^5.*sin(5*x).^6; % function
quad( f, -1, 1, 1e-14 )                     % integral

%% Lecture 1:
% Investigate the matrix Kn
% Kn = "2nd order central difference matrix" (see Class 2)

%% Make Kn: (Kn is a Toeplitz matrix, i.e., constant along diagonals.)
n = 7; 
Kn = toeplitz( [2 -1 zeros(1,n-2)] );     % slow for very large n!

%v = ones(n,1); 
%Kn = spdiags([-v 2*v -v],[-1 0 1],n,n);   % fast for very large n.
Kn

%% Symmetry: 
Kn'                   % transpose

%% Sparse: 
nnz( Kn )             % number of nonzero entries 
n^2                   % number of entries
ratio = nnz(Kn)/n^2   % ratio

%% Tridiagonal: 
Kn                    % Take a look, only three nonzero diagonals

%% Invertible: 
det(Kn)               % det(Kn) = n+1
f = randn( n, 1); 
u = Kn \ f            % Solve Kn*u = f (by elimination)

%% Positive definite (more about this later)
eig( Kn ) > 0         % all eigenvalues >0. 

%% Cn
% Slightly nicer matrix perhaps, all rows are shifts of 
% each other. Fourier loves this matrix because it is shift-invariant 
% (more about this later). 
n = 5; 
Cn = toeplitz( [2 -1 zeros(1,n-2)] ); 
Cn(1,n) = -1; Cn(n,1) = -1; 
Cn 

%% Try shifting the rows for yourself: 
circshift( Cn, -5 )

%% Solve Beagle2 as a boundary value problem: 
% 
% Solve -u''(t) = f(t),    Looks like a = F/m (Newton's 2nd law), 
%                                u''(t) = acceleration 
%                                f(t) = force from gravity and 
%                                       rockets
% Boundary data:    u(0) = a   (we know where Beagle2 was deployed by Mars Express)
%                   u(1) = b   (we know where Beagle2 crashed) 

% More about what is going on below in Class 2: 
n = 100;  t = linspace(0,1,n+2); 
Kn = toeplitz( [2 -1 zeros(1,n-2)] ); 
u0 = 0; un = 1; h = 1/(n+1);

% Forces such as gravity and rockets: 
f = h^2*[50*ones(n/4,1) ; -5*ones(3*n/4,1)];
%f =    [ gravity/free fall ;  rocket on  ];
f(end) = f(end) + un; 
plot(f(1:end-1),'linewidth',2), hold on, 
xlabel('t','fontsize',16), ylabel('force','fontsize',16)
text(2,4.5e-3,'Free fall','fontsize',20)
text(50,0,'Rockets are on','fontsize',20)
set(gca,'fontsize',16)

%% Solve for Beagle2's path: 
u = Kn \ f;                     % Solve it. 
u = [u0 ; u ; un];
plot(t, u,'linewidth',2), hold on, 
plot(t,0*t+1,'k--','linewidth',2), 
set(gca,'fontsize',16), set(gca,'YDir','reverse')
xlabel('t','fontsize',16), ylabel('u','fontsize',16)
title('Crash!','fontsize',20)

%% Can you make Beagle 2 land safely? Hint: change the rocket.