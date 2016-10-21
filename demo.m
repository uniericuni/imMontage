close all;
clear;
clc;

imRef = imread('/Users/eric/Desktop/JAPAN_sakuraNkimono/IMG_4132.jpg');
folder = '/Users/eric/Pictures/AmberOnScreen/';
out = imMontage(imRef, folder, 9, 0.4);
imshow(out);
imwrite(out, 'demo.png');