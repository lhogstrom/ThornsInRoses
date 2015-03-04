%%%%% 
%% 3/2/2015 - spectral analysis of images
%%%%%

%%%
%% Begin with this example: http://biocomp.cnb.csic.es/~coss/Docencia/ImageProcessing/Tutorial/
%%%
    % Prepare image 
    f = zeros(30,30); 
    % f(5:24,13:17) = 1;
    f(5:24,5:24) = diag(ones(20,1)) + diag(ones(19,1),1) + diag(ones(19,1),-1);
    % f= f' 
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


%% load real-world images

    % Town Hall building
%     path1 = '/Users/hogstrom/Dropbox (MIT)/Neuron_data/Fourier_analysis';
% %     file1 = fullfile(path1, 'bch_beams.jpg');
%     file1 = fullfile(path1, 'bch2.jpg');

    % confocal image
    path1 = '/Users/hogstrom/Dropbox (MIT)/Larson/confocal';
    %file1 = fullfile(path1, 'Syn1_2000X_PSD95_MAP2_M100X_2.png');
    file1 = fullfile(path1, 'Syn1_2000X_PSD95_MAP2_M60X.png');
    
    A = imread(file1);
    f = A(:,:,3);
    %f = ind2gray(f,gray(256));
    figure, imshow(f)

    % Compute Fourier Transform 
    %F = fft2(f,1456,2592); 
    F = fft2(double(f)); 
    %F = fftshift(F); % Center FFT

    %Display magnitude and phase of 2D FFTs
    figure, imshow(abs(fftshift(F)),[24 100000]), colormap gray
    title('Image A FFT2 Magnitude')
    figure, imshow(angle(fftshift(F)),[-pi pi]), colormap gray
    title('Image A FFT2 Phase')
    %%
    % Measure the minimum and maximum value of the transform amplitude 
    min(min(abs(F))) %   0 
    max(max(abs(F))) % 100 
    imshow(abs(F),[0,10000]); colormap(jet); colorbar 
    % show at log scale
    imshow(log(1+abs(F)),[0,3]); colormap(jet); colorbar 

    %% Perform inverse 2D FFTs on switched images
    imageC = ifft2(F);
    figure, imshow(abs(imageC), [24 100])

%% or with alternative image

% confocal image
path1 = '/Users/hogstrom/Dropbox (MIT)/Larson/confocal';
%file1 = fullfile(path1, 'Syn1_2000X_PSD95_MAP2_M100X_2.png');
file1 = fullfile(path1, 'Syn1_2000X_PSD95_MAP2_M60X.png');
A = imread(file1);

%imshow(A)
f = A(:,:,3);
imshow(f)