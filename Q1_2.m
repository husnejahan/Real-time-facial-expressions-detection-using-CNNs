% 1.2
% imfilter performs correlation by default. 
% However, it will also return the convolution result if you supply 'conv' as an optional argument
clc;
clear all;
close all;
A=[-5  0   0  0  0  0  0  0  0  0
    0  0   0  0  0  0  0  0  0  0
    0  0  -7  2  1  1  3  0  0  0
    0  0   0  1  1  1  1  0  0  0
    0  0  -0  3  1  1  5  0  0  0
    0  0   0 -1 -1 -1 -1  0  0  0
    0  0   0  1  2  3  4  0  0  0
    0  0   0  0  0  0  0  0  0  0
    0  0   0  0  0  0  0  0  0  0];
h=[-1 
    0 
    1];

% imfilter(A,h)%for correlation
out=imfilter(A,h,'conv');
fprintf('\ngradient magnitude At pixel [2;3] is = %d\n',out(2,3))
fprintf('\ngradient magnitude At pixel [4;3] is = %d\n',out(4,3))
fprintf('\ngradient magnitude At pixel [4;6] is = %d\n',out(4,6))