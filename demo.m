close all;
clear;
clc;

imRef = imread('path/to/the/referenceImage');
folder = 'path/to/the/photoColectionFolder/';
out = imMontage(imRef, folder, 9, 0.4, 0.3);
imshow(out);
imwrite(out, 'demo.png');