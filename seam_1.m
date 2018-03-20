
% The algorithm is as follows:
% Compute the gradient of the image.
% Compute the cumulative energy map with the gradients. An energy value at a pixel measures its contrast with its neighboring pixels. If we're computing a vertical energy map, then for every pixel starting from the second row, we take the value of the magnitude of the gradient at the current pixel, then the minimum of the pixels that are its neighbors from the row above the current pixel. The algorithm is symmetric for a horizontal energy map. This can be done via dynamic programming or Dijikstra's algorithm.
% Find the pixel with the minimum energy value at the last row for a vertical energy map or last column for horizontal energy map.
% Backtrace from the pixel found in step 3 all the way to the first row to get the vertical seam.
% Remove the seam from the image.
% Repeat steps  n-1 times to remove n seams.

clear all;
clc;
close all;

% img = imread('ryerson.jpg');
img=imread('image.jpg');
subplot(4,2,1);imshow(img);title('original(720*480)image');

img = double(img) / 255.0;
x=80;%720*480 to 640*480
y=160;%720*480 to 720*320
MySeamCarving(img,x,y);

function [carvedV,carvedH]=CarvingHelper(img,m,n)
        
         carvedV = carveVertSeams(img,n);
         
         carvedH = carveHorizSeams(img,m);
        
 end
function MySeam=MySeamCarving(img,x,y)
         
         [carvedV,carvedH]=CarvingHelper(img,x,y);
         subplot(4,2,3);imshow(carvedV);title('160 vertical seams removed');
         subplot(4,2,4);imshow(carvedH);title('80 horizontal seams removed');
         
         img1=permute(carvedV,[2 1 3]);
         img2=permute(carvedH,[2 1 3]);
         [carvedV,carvedH]=CarvingHelper(img1,x,y);
         subplot(4,2,5);imshow(carvedV);title('160 vertical seams removed(transposed)');
         subplot(4,2,6);imshow(carvedH);title('80 horizontal seams removed(transposed)');
 
         [carvedV,carvedH]=CarvingHelper(img2,x,y);
         subplot(4,2,7);imshow(carvedV);title('160 vertical seams removed(transposed)');
         subplot(4,2,8);imshow(carvedH);title('80 horizontal seams removed(transposed)');

end
   