
function carved = carveHorizSeams(img, n)
    carved = img;
    
    for seam=1:n
        horiz = MinHorizPathMap(carved); % update accumulated energy map
        h = comHorizSeam(horiz); % find seam
        carved = horizSeamCarve(carved, h); % cut seams from img
    end;