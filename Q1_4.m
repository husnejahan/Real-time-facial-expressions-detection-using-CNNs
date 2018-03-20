% 1.4 

clc;
clear all;
close all;
% using imfilter
A= randi([0, 1], [15,15]);
subplot(2, 2, 1);imshow(A);title('Arbitary image')
% [m n] = size(A)
h = fspecial('gaussian',[13 13],2);
Im = imfilter(A,h);
%size(Im)
subplot(2, 2, 2);imshow(Im);title('Output using imfilter')
%%using loop
I = randi([0, 1], [3,3]);
k=randi([0 1],[13,13]);
outconv = MyConv(I, k);
subplot(2, 2, 3);imshow(outconv);title('Output using loop');
% size(outconv)
x=abs(Im-outconv);
subplot(2, 2, 4);imshow(x);title('Subtracted output');
fprintf('\nDifference between the output:\n')
fprintf('imfilter using Gaussian 2D kernel, is a linear filter.\n')
fprintf('It is usually used to blur the image or to reduce noise\n')
fprintf('The weights give higher significance to pixels near the edge (reduces edge blurring)\n') 
fprintf('In this case, Gaussian filter alone blur edges and reduces contrast\n')
fprintf('Here we can control the degree of smoothing by sigma(larger sigma for more intensive smoothing\n')
fprintf('Whereas using loop, it removes noise while keeping edges relatively sharp\n\n')
function B = MyConv(A, k) 
[r,c] = size(A);
[m,n] = size(k);
h = rot90(k, 2);
center = floor((size(h)+1)/2);
Rep = zeros(r + m*2-2, c + n*2-2);
for x = m : m+r-1
    for y = n : n+r-1
        Rep(x,y) = A(x-m+1, y-n+1);
    end
end
B = zeros(r+m-1,n+c-1);
for x = 1 : r+m-1
    for y = 1 : n+c-1
        for i = 1 : m
            for j = 1 : n
                B(x, y) = B(x, y) + (Rep(x+i-1, y+j-1) * h(i, j));
            end
        end
    end
end
end
