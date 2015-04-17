%% Class 8: 
% Alex Townsend, 5th March 2015
%        ajt@mit.edu

%% Images (how compressible am I?) 
I = imread( '/Users/hogstrom/Desktop/ullSizeRender.jpg' ); 
imshow( I ) 

%% 
A = rgb2gray( I ); 
imshow( A ) 

%% I am of rank 50... Mostly full of hot air then. 
[U, S, V] = svd( double( A ) );

for k = 1:50
    B = U(:,1:k) * S(1:k,1:k) * V(:,1:k)';  % rank k 
    imshow( uint8( B ) ) 
    s = sprintf('Rank %u',k);
    title(s,'fontsize',16)
    pause(.1), drawnow, shg
end

%% Rank 1 matrix: 
A = [1 2 3 ; 1/10 2/10 3/10 ; 1/pi 2/pi 3/pi]; 

x = [1 1/10 1/pi]'; 
y = [1 2 3]'; 

A
x*y'

%% Rank 1 matrix 
A = rand(3,1)*rand(1, 3)  % rank 1

%% Rank 2 matrix
A = rand(3,2)*randn(2,3)  % rank 2 









