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
file1 = fullfile(path1, 'Syn1_2000X_PSD95_MAP2_M60X.png');


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
T = 600; % set arbitrary threshold 
g = g >= T;
imshow(g)

%% look at morphology
% bwmorph(a, 'bothat', 1)

%% line detection

%w = [2 -1 -1; -1 2 -1; -1 -1 2]; %45 degree 
% w = [-1 -1 -1; 2 2 2; -1 -1 -1]; %horizontal  
% w = [-1 2 -1; -1 2 -1; -1 2 -1]; %vertical

% horizontal line
p = 14
w = zeros(p);
w(:) = -1;
% w(2:3,:) = 2; % horizontal
w(10:12,:) = 2; % horizontal
g = abs(imfilter(double(a),w));
g = imfilter(double(a),w);
%imshow(g)
% highest 5% of correlated values
npix = length(g(:));
gs = sort(g(:),'descend');
ithresh = (npix * .01);
thresh = gs(round(ithresh));
gt_horiz = g >= thresh;
imshow(gt)

% verical lines
p = 8
w = zeros(p);
w(:) = -1;
w(:,2:3) = 2; % verical
g = abs(imfilter(double(a),w));
g = imfilter(double(a),w);
%imshow(g)
% highest 5% of correlated values
npix = length(g(:));
gs = sort(g(:),'descend');
ithresh = (npix * .01);
thresh = gs(round(ithresh));
gt_vert = g >= thresh;
imshow(gt)

HorVert = zeros(512,512,3);
HorVert(:,:,1) = a;
HorVert(:,:,2) = gt_horiz*200;
HorVert(:,:,3) = gt_vert*300;
HorVert = uint8(HorVert);
imshow(HorVert)

%% capture both sides of edges

% horizontal line
p = 14
w = zeros(p);
w(:) = -1;
w(12:14,:) = 4; % horizontal above
g = abs(imfilter(double(a),w));
g = imfilter(double(a),w);
% highest 5% of correlated values
npix = length(g(:));
gs = sort(g(:),'descend');
ithresh = (npix * .01);
thresh = gs(round(ithresh));
gt_horiz = g >= thresh;
imshow(gt)

% verical lines
p = 8
w = zeros(p);
w(:) = -1;
w(:,7:8) = 4; % verical
g = abs(imfilter(double(a),w));
g = imfilter(double(a),w);
%imshow(g)
% highest 5% of correlated values
npix = length(g(:));
gs = sort(g(:),'descend');
ithresh = (npix * .01);
thresh = gs(round(ithresh));
gt_vert = g >= thresh;
imshow(gt)

HorVert = zeros(512,512,3);
HorVert(:,:,1) = a;
HorVert(:,:,2) = gt_horiz*200;
HorVert(:,:,3) = gt_vert*300;
HorVert = uint8(HorVert);
imshow(HorVert)

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
% path1 = '/Users/hogstrom/Dropbox (MIT)/Data Share/CA3 Scan';
path1 = '/Users/hogstrom/Dropbox (MIT)/Data Share/Cerebellar Scan';
file1 = fullfile(path1, 'XY_stack.tif');

info = imfinfo(file1);
imageStack = [];
greyStack = [];
numberOfImages = length(info);
for k = 1:numberOfImages
    currentImage = imread(file1, k, 'Info', info);
    imageStack(:,:,k) = currentImage;
    greyStack(:,:,k) =  im2bw(currentImage,graythresh(currentImage));
end 

%% apply line detection to one frame of data

a = imageStack(:,:,300);

% horizontal line
p = 14
w = zeros(p);
w(:) = -1;
% w(2:3,:) = 2; % horizontal
w(10:12,:) = 2; % horizontal
g = abs(imfilter(double(a),w));
g = imfilter(double(a),w);
%imshow(g)
% highest 5% of correlated values
npix = length(g(:));
gs = sort(g(:),'descend');
ithresh = (npix * .01);
thresh = gs(round(ithresh));
gt_horiz = g >= thresh;
imshow(gt)

% verical lines
p = 8
w = zeros(p);
w(:) = -1;
w(:,2:3) = 2; % verical
g = abs(imfilter(double(a),w));
g = imfilter(double(a),w);
%imshow(g)
% highest 5% of correlated values
npix = length(g(:));
gs = sort(g(:),'descend');
ithresh = (npix * .01);
thresh = gs(round(ithresh));
gt_vert = g >= thresh;
imshow(gt)

HorVert = zeros(512,512,3);
HorVert(:,:,1) = a;
HorVert(:,:,2) = gt_horiz*200;
HorVert(:,:,3) = gt_vert*300;
HorVert = uint8(HorVert);
imshow(HorVert)

%% adapt boundary example to ExM

%BW = im2bw(I, graythresh(I));
%BW = im2bw(imageStack,graythresh(imageStack));
[B,L] = bwboundaries(greyStack,'noholes');
imshow(label2rgb(a, @jet, [.5 .5 .5]))
hold on
for k = 1:length(B)
   boundary = B{k};
   plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
end
