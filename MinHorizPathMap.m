
function M = MinHorizPathMap(img)
    % compute magnitudes of gradients of img
    E = rgb2gray(img);
    [dy, dx] = gradient(E);
    E = hypot(dy,dx);
    [dimY,dimX] = size(E);
    M = E;
    
    % iterate starting from the second column, adding the value at the 
    % current pixel and the minimum of the pixels that are 'connected'
    % from the preceding column
    for x=2:dimX
        for y=1:dimY
            if (y == 1)
                M(y,x) = E(y,x) + min([M(y,x-1), M(y+1,x-1)]);
            elseif (y == dimY)
                M(y,x) = E(y,x) + min([M(y,x-1), M(y-1,x-1)]);
            else
                M(y,x) = E(y,x) + min([M(y-1,x-1), M(y,x-1), M(y+1,x-1)]);
            end;
        end;
    end;
    