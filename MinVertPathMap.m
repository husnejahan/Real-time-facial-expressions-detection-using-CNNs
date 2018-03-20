
function M = MinVertPathMap(img)
    % compute magnitudes of gradients of img
    E = rgb2gray(img);
    [dy, dx] = gradient(E);
    E = hypot(dy,dx);
    [dimY,dimX] = size(E);
    M = E;
    
    % iterate starting from the second row, adding the value at the 
    % current pixel and the minimum of the pixels that are 'connected'
    % from the preceding row
    for y=2:dimY
        for x=1:dimX
            if (x == 1)
                M(y,x) = E(y,x) + min([M(y-1,x), M(y-1,x+1)]);
            elseif (x == dimX)
                M(y,x) = E(y,x) + min([M(y-1,x), M(y-1,x-1)]);
            else
                M(y,x) = E(y,x) + min([M(y-1,x-1), M(y-1,x), M(y-1,x+1)]);
            end;
        end;
    end;
    