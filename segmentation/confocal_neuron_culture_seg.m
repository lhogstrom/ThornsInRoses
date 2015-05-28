%% load confocal image

path1 = '/Users/hogstrom/Dropbox (MIT)/imaging_data/20150520';
file1 = fullfile(path1, 'primary_neuron_20150520_2_w2Conf 488.TIF');

%% read multistack tiff

info = imfinfo(file1);
num_images = numel(info);
h = info.Height;
w = info.Width;
A = zeros(h,w,num_images);
for k = 1:num_images
%     A = imread(file1, k);
    A(:,:,k) = imread(file1, k);
end

%%
a = A(:,:,15);

% A = imread(file1);
% imshow(A)
imshow(a, [min(min(a)),max(max(a))])
%%

% a_mask = a>110;
% imshow(a_mask)