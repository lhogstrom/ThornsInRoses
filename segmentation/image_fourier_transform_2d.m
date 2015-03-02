%%%%% 
%% 3/2/2015 - spectral analysis of images
%%%%%

%%%
%% Begin with this example: http://biocomp.cnb.csic.es/~coss/Docencia/ImageProcessing/Tutorial/
%%%

% Prepare image 
f = zeros(30,30); 
f(5:24,13:17) = 1; 
imshow(f)

%% or with alternative image
f = imread('saturn.tif'); 
f = ind2gray(f,gray(256));
imshow(f)

%%
% Compute Fourier Transform 
F = fft2(f,256,256); 
F = fftshift(F); % Center FFT

% Measure the minimum and maximum value of the transform amplitude 
min(min(abs(F))) %   0 
max(max(abs(F))) % 100 
imshow(abs(F),[0,100]); colormap(jet); colorbar 

%%
imshow(log(1+abs(F)),[0,3]); colormap(jet); colorbar 

%%
% Look at the phases 
imshow(angle(F),[-pi,pi]); colormap(jet); colorbar