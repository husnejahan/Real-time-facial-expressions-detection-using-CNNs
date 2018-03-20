% 1.3 %
clc;
clear all;
close all;
% I1 = randi([0, 1], [5,5]);
I1= imread('image1.jpg');
subplot(2,2,1);imshow(I1);title('Arbitary image');
I = imresize(I1,[5 5]);
[a,b] = size(I);
 k= randi([0, 1], [a,b]);
% k = fspecial('gaussian',[r c],0.5);
% fprintf('Convolution output using loop\n')
% k = fspecial('average',[a,b])
conv=MyConv(I, k)
subplot(2,2,2);imshow(conv);title('Arbitary image');
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

