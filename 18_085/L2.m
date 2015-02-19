%% Class 2: 
% Alex Townsend, 5th Feb 2015
%        ajt@mit.edu

%% Forward differences:
f = @(x) 2*x.^3 - x.^2 - x + 1;
x = linspace(-1,1);
plot(x,f(x),'linewidth',2), hold on
set(gca,'fontsize',16)
plot(0,f(0),'.r','markersize',20)
title(' df/dx   =   -1 ', 'fontsize',20)

%% Forward differences: 
for h = [.9:-.01:.01 .01:-.001:.001 .0001]
    
    f = @(x) 2*x.^3 - x.^2 - x + 1;
    x = linspace(-1,1);
    plot(x,f(x),'linewidth',2), hold on
    tangent = @(x) -x + 1;
    plot(x,tangent(x), 'k-','linewidth',2)
    set(gca,'fontsize',16)
    plot(0,f(0),'.k','markersize',30)
    plot(h,f(h),'r.','markersize',30)
    tf = (f(h) - f(0))/h;
    title(sprintf(' df/dx   =   %1.3f ',tf), 'fontsize',20)
    fd = @(x) tf * x + f(0);
    plot(x, fd(x),'r-','linewidth',2 ), shg, axis([-1 1 -1 2]), pause(.1)
    hold off
end

%% Backward differences: 

for h = [.9:-.01:.01 .01:-.001:.001 .0001]
    f = @(x) 2*x.^3 - x.^2 - x + 1;
    x = linspace(-1,1);
    plot(x,f(x),'linewidth',2), hold on
    tangent = @(x) -x + 1;
    plot(x,tangent(x), 'k-','linewidth',2)
    set(gca,'fontsize',16)
    plot(0,f(0),'.r','markersize',30)
    plot(-h,f(-h),'r.','markersize',30)
    tf = (f(0) - f(-h))/h;
    title(sprintf(' df/dx   =   %1.3f ',tf), 'fontsize',20)
    fd = @(x) tf * x + f(0);
    plot(x, fd(x),'r-','linewidth',2 ), shg, axis([-1 1 -1 2]), pause(.1)
    hold off
end

%% Central differences: 

for h = [.9:-.01:.01 .01:-.001:.001 .0001]
    f = @(x) 2*x.^3 - x.^2 - x + 1;
    x = linspace(-1,1);
    plot(x,f(x),'linewidth',2), hold on
    tangent = @(x) -x + 1;
    plot(x,tangent(x), 'k-','linewidth',2)
    set(gca,'fontsize',16)
    plot(-h,f(-h),'.r','markersize',30)
    plot(h,f(h),'r.','markersize',30)
    tf = (f(h) - f(-h))/h/2;
    title(sprintf(' df/dx   =   %1.3f ',tf), 'fontsize',20)
    fd = @(x) tf * (x+h) + f(-h);
    plot(x, fd(x),'r-','linewidth',2 ), shg, axis([-1 1 -1 2]), pause(.1)
    hold off
end

%% Kn times a vector: 
n = 20;
Kn = toeplitz( [2 -1 zeros(1,n-2)] );

x = ones(n, 1); 
%x = (1:n)'; 
%x = (1:n)'.^2
%x = [zeros(n/2,1);(1:n/2)'];
%x = sin( (1:n)'/2 );
subplot(1,2,1)
plot( x(2:end-1),'.r','markersize',30)
xlim([1 n-2]),set(gca,'fontsize',20)
title('x','fontsize',20)
subplot(1,2,2)
v = -Kn * x; 
plot( v(2:end-1),'.r','markersize',30) 
xlim([1 n-2]), set(gca,'fontsize',20)
title('\Delta^2 x', 'fontsize', 20) 