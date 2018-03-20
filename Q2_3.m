% Steps/Algorithm Details : 
% 1. Convolution with Gaussian Filter Coefficient 
% 2. Convolution with Canny Filter for Horizontal and Vertical orientation 
% 3. Calculating directions using atan2 
% 4. Adjusting to nearest 0, 45, 90, and 135 degree 
% 5. Non-Maximum Suppression 
% 6. Hystheresis Thresholding

clear all;
clc;
close all;
%Value for Thresholding
t_Low = 0.075;
t_High = 0.175;

%Gaussian Filter Coefficient
b = [2, 4, 5, 4, 2; 4, 9, 12, 9, 4;5, 12, 15, 12, 5;4, 9, 12, 9, 4;2, 4, 5, 4, 2 ];
b = 1/159.* b;
%Input image
img = imread ('image.jpg');
subplot(2,2,1);imshow(img);title('original image');
img1 = rgb2gray(img);
img2 = double (img1);

canny(b,t_Low,t_High,img2);

function MyCanny=canny(B,T_Low,T_High,img2)

%Convolution of image by Gaussian Coefficient
A=conv2(img2, B, 'same');

%Filter for horizontal and vertical direction
KGx = [-1, 0, 1; -2, 0, 2; -1, 0, 1];
KGy = [1, 2, 1; 0, 0, 0; -1, -2, -1];

%Convolution by image by horizontal and vertical filter
Filtered_X = conv2(A, KGx, 'same');
Filtered_Y = conv2(A, KGy, 'same');

%Calculate directions/orientations
DR = atan2 (Filtered_Y, Filtered_X);
DR = DR*180/pi;

pan=size(A,1);
leb=size(A,2);

%Adjustment for negative directions, making all directions positive
for i=1:pan
    for j=1:leb
        if (DR(i,j)<0) 
            DR(i,j)=360+DR(i,j);
        end;
    end;
end;

DR2=zeros(pan, leb);

%Adjusting directions to nearest 0, 45, 90, or 135 degree
for i = 1  : pan
    for j = 1 : leb
        if ((DR(i, j) >= 0 ) && (DR(i, j) < 22.5) || (DR(i, j) >= 157.5) && (DR(i, j) < 202.5) || (DR(i, j) >= 337.5) && (DR(i, j) <= 360))
            DR2(i, j) = 0;
        elseif ((DR(i, j) >= 22.5) && (DR(i, j) < 67.5) || (DR(i, j) >= 202.5) && (DR(i, j) < 247.5))
            DR2(i, j) = 45;
        elseif ((DR(i, j) >= 67.5 && DR(i, j) < 112.5) || (DR(i, j) >= 247.5 && DR(i, j) < 292.5))
            DR2(i, j) = 90;
        elseif ((DR(i, j) >= 112.5 && DR(i, j) < 157.5) || (DR(i, j) >= 292.5 && DR(i, j) < 337.5))
            DR2(i, j) = 135;
        end;
    end;
end;

% figure, imagesc(arah2); colorbar;

%Calculate magnitude
magnitude = (Filtered_X.^2) + (Filtered_Y.^2);
magnitude2 = sqrt(magnitude);

SP = zeros (pan, leb);

%Non-Maximum Supression
for i=2:pan-1
    for j=2:leb-1
        if (DR2(i,j)==0)
            SP(i,j) = (magnitude2(i,j) == max([magnitude2(i,j), magnitude2(i,j+1), magnitude2(i,j-1)]));
        elseif (DR2(i,j)==45)
            SP(i,j) = (magnitude2(i,j) == max([magnitude2(i,j), magnitude2(i+1,j-1), magnitude2(i-1,j+1)]));
        elseif (DR2(i,j)==90)
            SP(i,j) = (magnitude2(i,j) == max([magnitude2(i,j), magnitude2(i+1,j), magnitude2(i-1,j)]));
        elseif (DR2(i,j)==135)
            SP(i,j) = (magnitude2(i,j) == max([magnitude2(i,j), magnitude2(i+1,j+1), magnitude2(i-1,j-1)]));
        end;
    end;
end;

SP = SP.*magnitude2;

subplot(2,2,2);imshow(DR2);title('Positive direction image');
subplot(2,2,3);imshow(SP);title('Non-max suprssion image');

%Hysteresis Thresholding
T_Low = T_Low * max(max(SP));
T_High = T_High * max(max(SP));

T_res = zeros (pan, leb);

for i = 1  : pan
    for j = 1 : leb
        if (SP(i, j) < T_Low)
            T_res(i, j) = 0;
        elseif (SP(i, j) > T_High)
            T_res(i, j) = 1;
        %Using 8-connected components
        elseif ( SP(i+1,j)>T_High || SP(i-1,j)>T_High || SP(i,j+1)>T_High || SP(i,j-1)>T_High || SP(i-1, j-1)>T_High || SP(i-1, j+1)>T_High || SP(i+1, j+1)>T_High || SP(i+1, j-1)>T_High)
            T_res(i,j) = 1;
        end;
    end;
end;

final_image = uint8(T_res.*255);
%Show final edge detection result
subplot(2,2,4);imshow(final_image);title('Final image');

end
