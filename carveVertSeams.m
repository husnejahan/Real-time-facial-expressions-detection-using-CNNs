
function carved = carveVertSeams(img, n)
    carved = img;
    
    for seam=1:n
        vert = MinVertPathMap(carved); % update accumulated energy map
        v = comVertSeam(vert); % find seam
        carved = vertSeamCarve(carved, v); % cut seam from img
    end;