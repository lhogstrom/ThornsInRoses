%% Class 9: 
% Alex Townsend, 9th March 2015
%        ajt@mit.edu

%% Rank-1 approximation of a circle is square-like: 
x = linspace(-2,2,500);  
f = @(x,y) x.^2+y.^2 < 1;  
[xx, yy] = meshgrid( x ); 
A = f(xx, yy); 
subplot(1,2,1), spy( A ),
[U, S, V] = svd( double( A ) ); 
for k = 1:100
    B = U(:,1:k) * S(1:k,1:k) * V(:,1:k)';  % rank k 
    subplot(1,2,2), spy( abs(B)>1e-12 )   
    s = sprintf('Rank %u',k);
    title(s,'fontsize',16), drawnow, shg
    if ( k == 1 ) pause; else pause(.1), end
end


%% It is more complicated than just simply a square, 
% as we can see using surf: 
x = linspace(-2,2,500);  
f = @(x,y) x.^2+y.^2 < 1;  
[xx, yy] = meshgrid( x ); 
A = f(xx, yy); 
subplot(1,2,1), surf(xx,yy, abs(A),'edgealpha',0,'facealpha', .5 )
[U, S, V] = svd( double( A ) ); 
for k = 1:100
    B = U(:,1:k) * S(1:k,1:k) * V(:,1:k)';  % rank k 
    subplot(1,2,2), surf(xx,yy, abs( B ),'edgealpha',0,'facealpha', .5 )  
    s = sprintf('Rank %u',k);
    title(s,'fontsize',16), drawnow, shg
    if ( k == 1 ) pause; else pause(.1), end
end