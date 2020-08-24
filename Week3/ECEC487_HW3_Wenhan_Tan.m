clear all; close all; clc;

%% File 1
fp = fopen('t10k-images.idx3-ubyte', 'rb');
magic = fread(fp, 1, 'int32', 0, 'ieee-be');

numImages = fread(fp, 1, 'int32', 0, 'ieee-be');
numRows = fread(fp, 1, 'int32', 0, 'ieee-be');
numCols = fread(fp, 1, 'int32', 0, 'ieee-be');
images = fread(fp, inf, 'unsigned char');

images = reshape(images, numCols, numRows, numImages);
images = permute(images,[2 1 3]);
images = reshape(images, size(images, 1) * size(images, 2), size(images, 3));
image(images);
title('Image 1')

fclose(fp);
zip('zipt10k-images.idx3-ubyte', 't10k-images.idx3-ubyte');

%% File 2
fp = fopen('t10k-labels.idx1-ubyte', 'rb');
magic = fread(fp, 1, 'int32', 0, 'ieee-be');

numImages = fread(fp, 1, 'int32', 0, 'ieee-be');
numRows = fread(fp, 1, 'int32', 0, 'ieee-be');
numCols = fread(fp, 1, 'int32', 0, 'ieee-be');
images = fread(fp, inf, 'unsigned char');

images = permute(images,[2 1 3]);
images = reshape(images, size(images, 1) * size(images, 2), size(images, 3));

fclose(fp);
zip('zipt10k-labels.idx1-ubyte', 't10k-labels.idx1-ubyte');

%% File 3
fp = fopen('train-labels.idx1-ubyte', 'rb');
magic = fread(fp, 1, 'int32', 0, 'ieee-be');

numImages = fread(fp, 1, 'int32', 0, 'ieee-be');
numRows = fread(fp, 1, 'int32', 0, 'ieee-be');
numCols = fread(fp, 1, 'int32', 0, 'ieee-be');
images = fread(fp, inf, 'unsigned char');

images = permute(images,[2 1 3]);
images = reshape(images, size(images, 1) * size(images, 2), size(images, 3));

fclose(fp);
zip('ziptrain-labels.idx1-ubyte', 'train-labels.idx1-ubyte');