%%% Adapted from D. Marshall 

%% load confocal image

path1 = '/Users/hogstrom/Dropbox (MIT)/imaging_data/20150520';
file1 = fullfile(path1, 'primary_neuron_20150520_2_w2Conf 488.TIF');

%% read multistack tiff

info = imfinfo(file1);
num_images = numel(info);
M = info.Height;
N = info.Width;
A = zeros(M,N,num_images);
for k = 1:num_images
%     A = imread(file1, k);
    A(:,:,k) = imread(file1, k);
end

%%
a = A(:,:,25);
% imshow(a, [min(min(a)),max(max(a))])

%% compute fft and display its spectra
F=fft2(double(a));
% figure(2);
% imshow(abs(fftshift(F)), [min(min(abs(F))),max(max(abs(F)))]);

%% compute Ideal Low Pass Filter

u0 = 100; % set cut off frequency
u=0:(M-1);
v=0:(N-1);
idx=find(u>M/2);
u(idx)=u(idx)-M;
idy=find(v>N/2);
v(idy)=v(idy)-N;
[V,U]=meshgrid(v,u);
D=sqrt(U.^2+V.^2);
H=double(D<=u0);
% display
% figure(3);
% imshow(fftshift(H));

%% Apply filter and do inverse FFT
G=H.*F;
g=real(ifft2(double(G)));
% Show Result
% figure(4);
% imshow(g,[min(min(a)),max(max(a))]); 

%% spacial filter
% w = fspecial('sobel');
% w = fspecial('prewitt');
w = fspecial('gaussian');
% w = fspecial('laplacian');
a_conv = imfilter(g,w);
min1 = min(min(a_conv));
max1 = max(max(a_conv));
% thresh = (min1+max1)/2;
thresh = 107
a_conv = a_conv>thresh;

% use edge tool
% a_conv = edge(g,'prewitt',.02);
% a_conv = edge(g,'sobel',.5);

% imshow(a_conv);
% a_mask = a>110;
% imshow(a_mask)


%% subplot
% figure
% subplot(2,1,1);
% imshow(a, [min(min(a)),max(max(a))])
% 
% subplot(2,1,2);
% imshow(g,[min(min(a)),max(max(a))]); 

figure
subplot(2,2,1);
imshow(a, [min(min(a)),max(max(a))])
title('origonal image','fontweight','bold','fontsize',16)

subplot(2,2,2);
imshow(fftshift(H));
title('frequency filter','fontweight','bold','fontsize',16)

subplot(2,2,3);
imshow(g,[min(min(a)),max(max(a))]); 
title('low pass image','fontweight','bold','fontsize',16)

subplot(2,2,4);
% imshow(a_conv,[min(min(a_conv)),max(max(a_conv))]); 
imshow(a_conv); 
title('convolved mask image','fontweight','bold','fontsize',16)
