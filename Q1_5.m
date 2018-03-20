% % 1.5
% I observed that the image is more blurry using 2D gaussian than 1D
tic
clc;
clear all;
close all;
A=imread('image1.jpg');
% size(A)
filtersize=[10 10];
%%using 1D Gaussian
h1 = fspecial('gaussian',[1 filtersize(1)],8);
I1= imfilter(A,h1);
%%using 2D Gaussian
h2 = fspecial('gaussian',[10 10],8);
I2 = imfilter(A,h2);
subplot(2, 2, 1);imshow(A);title('Input image');
subplot(2, 2, 2);imshow(I1);title('1D gaussian');
subplot(2, 2, 3);imshow(I2);title('2D gaussian(more blury than 1D)');
z=toc;
fprintf('\nExecution time for the script %f\n', z)
fprintf('\nAns:\n')
fprintf('I observed that the image is more blurry using 2D gaussian than 1D\n\n')