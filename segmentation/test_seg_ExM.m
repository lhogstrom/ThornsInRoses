%% load boundary example
       BW = imread('blobs.png');
       [B,L,N] = bwboundaries(BW);
       imshow(BW); hold on;
       for k=1:length(B),
         boundary = B{k};
         if(k > N)
           plot(boundary(:,2), boundary(:,1), 'g','LineWidth',2);
         else
           plot(boundary(:,2), boundary(:,1), 'r','LineWidth',2);
         end
       end
       
%% second boundary example

       I = imread('rice.png');
       BW = im2bw(I, graythresh(I));
       [B,L] = bwboundaries(BW,'noholes');
       imshow(label2rgb(L, @jet, [.5 .5 .5]))
       hold on
       for k = 1:length(B)
           boundary = B{k};
           plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
       end
       
%% load confocal image

% confocal image
path1 = '/Users/hogstrom/Dropbox (MIT)/Larson/confocal';
file1 = fullfile(path1, 'Syn1_2000X_PSD95_MAP2_M100X_2.png');

A = imread(file1);
% imshow(A)
 imshow(A(:,:,1))

a = A(:,:,3);
a_mask = a>40;
% imshow(a_mask);
%image(a_mask);

%% point detection 

w = [-1 -1 -1; -1 8 -1; -1 -1 -1];
g = abs(imfilter(double(a),w));
% T = max(g(:));
T = 600;
g = g >= T;
imshow(g)

%% adapt boundary example to confocal


       %BW = im2bw(I, graythresh(I));
       BW = im2bw(a,graythresh(a));
       [B,L] = bwboundaries(BW,'noholes');
       imshow(label2rgb(a, @jet, [.5 .5 .5]))
       hold on
       for k = 1:length(B)
           boundary = B{k};
           plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
       end

%% load ExM data

% 
path1 = '/Users/hogstrom/Dropbox (MIT)/Data Share/CA3 Scan';
file1 = fullfile(path1, 'XY_stack.tif');

info = imfinfo(file1);
imageStack = [];
numberOfImages = length(info);
for k = 1:numberOfImages
    currentImage = imread(file1, k, 'Info', info);
    imageStack(:,:,k) = currentImage;
end 

%% adapt boundary example to ExM


%BW = im2bw(I, graythresh(I));
BW = im2bw(imageStack,graythresh(imageStack));
[B,L] = bwboundaries(BW,'noholes');
imshow(label2rgb(a, @jet, [.5 .5 .5]))
hold on
for k = 1:length(B)
   boundary = B{k};
   plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
end
