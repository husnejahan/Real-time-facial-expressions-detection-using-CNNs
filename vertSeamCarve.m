function carved = vertSeamCarve(img, vertSeam)
    [dimY, dimX, dimD] = size(img);
    carved = zeros(dimY, dimX-1, dimD);
    
    for y=1:dimY
        % cut the seam out of the image
        carved(y,:,:) = img(y,[1:vertSeam(y)-1,vertSeam(y)+1:dimX],:);
    end;