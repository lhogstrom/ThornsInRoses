%% Class 7: 
% Alex Townsend, 3rd March 2015
%        ajt@mit.edu

%% Finding roots of polynomials: 
p = @(x) x.^5 - pi/10*x.^4-(pi^2/16+1)*x.^3 + (pi^3/160+pi/10)*x.^2 + pi^2*x/16-pi^3/160; 
%p = (x-pi/10).*(x-1).*(x-pi/4).*(x+pi/4).*(x+1);
x = linspace(-1.1,1.1); 
plot(x,p(x),'b-','linewidth',2), hold on, 
set(gca,'fontsize',16), title('Polynomial','fontsize',16)
shg

%% 
C = diag(ones(4,1),-1); 
C(:,end) = [pi^3/160 -pi^2/16 -(pi^3/160+pi/10) (pi^2/16+1) pi/10]';
r = eig( C ); 
plot( r, p(r), '.r','markersize',30)
shg

%% Global optimization 
dp = @(x) 5*x.^4 - 4*pi/10*x.^3-3*(pi^2/16+1)*x.^2 + 2*(pi^3/160+pi/10)*x + pi^2*x/16; 
C = diag(ones(3,1),-1); 
C(:,end) = [-pi^2/16 -2*(pi^3/160+pi/10) 3*(pi^2/16+1) 4*pi/10]'/5;

r = eig( C ); 
plot( r, p(r), '.g','markersize', 30)
shg

%% Gerschgorin's Theorem

A = [1 2 ; 1 5];
A = [1 -2 ; 1 -1];
A = [10 -2 0 1; .2 8 .2 .2; 1 1 2 1; -.2 -.1 0 -3]; 
ev = eig( A ); 
plot(ev+1i*eps, 'r.', 'markersize', 30), hold on,

for j = 1:size(A,1) 
    t = linspace(0, 2*pi);
    a = A(j,:); a(j) = []; 
    rowSum = sum( abs(a) ) + eps*1i;  
    plot( A(j,j) + rowSum * exp(1i*t),'k-','linewidth',2)
end
plot(ev+1i*eps, 'r.', 'markersize', 30), hold on,
axis equal, set(gca,'fontsize',16)


%% Kn times a vector: 
n = 20; h = 1/(n+1); 
Kn = toeplitz( [2 -1 zeros(1,n-2)] );

x = ones(n, 1); 
%x = (1:n)'; 
%x = (1:n)'.^2
%x = sin( 2*(1:n)'*pi*h );
subplot(1,2,1)
plot( x(2:end-1),'.r','markersize',30)
xlim([1 n-2]),set(gca,'fontsize',20)
title('x','fontsize',20)
subplot(1,2,2)
v = -Kn * x; 
plot( v(2:end-1),'.r','markersize',30) 
xlim([1 n-2]), set(gca,'fontsize',20)
title('\Delta^2 x', 'fontsize', 20) 