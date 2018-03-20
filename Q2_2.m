% Steps/Algorithm Details : 
% 1. Convolution with Gaussian Filter Coefficient 
% 2. Convolution for Horizontal and Vertical orientation 

clear all;
clc;
close all;

%Gaussian Filter Coefficient
b = [2, 4, 5, 4, 2; 4, 9, 12, 9, 4;5, 12, 15, 12, 5;4, 9, 12, 9, 4;2, 4, 5, 4, 2 ];
b = 1/159.* b;
%Input image
img = imread ('image.jpg');
subplot(2,2,1);imshow(img);title('original image');
img1 = rgb2gray(img);
img2 = double (img1);

%Convolution of image by Gaussian Coefficient
A=conv2(img2, b, 'same');
%Filter for horizontal and vertical direction
KGx = [-1, 0, 1; -2, 0, 2; -1, 0, 1];
KGy = [1, 2, 1; 0, 0, 0; -1, -2, -1];

%Convolution by image by horizontal and vertical filter
Filtered_X = conv2(A, KGx, 'same');
Filtered_Y = conv2(A, KGy, 'same');

subplot(2,2,2);imshow(Filtered_X);title('horizontal filtered image');
subplot(2,2,3);imshow(Filtered_Y);title('vertical filtered image');

