
function [carved, eM] = horizSeamCarve(img, horizSeam)
    [dimY, dimX, dimD] = size(img);
    carved = zeros(dimY-1, dimX, dimD);
    
    for x=1:dimX
        % cut the seam out of the image
        carved(:,x,:) = img([1:horizSeam(x)-1,horizSeam(x)+1:dimY],x,:);
    end;