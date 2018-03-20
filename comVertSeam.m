function vertSeam = findVertSeam(energyMap)
    [dimY, dimX] = size(energyMap);
    vertSeam = zeros(dimY,1);
    [minV, minCol] = min(energyMap(dimY,:));
    x = minCol;
    vertSeam(dimY) = x;

    % start from the last row with the smallest value in the accumulated 
    % energy map, then for each pixel, choose the connected pixel that has 
    % the minimum value
    for y=dimY-1:-1:2
        if (x == 1)
            [minV, minPos] = min([energyMap(y-1,x), energyMap(y-1,x+1)]);
            if (minPos == 2)
                x = x + 1;
            end;
        elseif (x == dimX)
            [minV, minPos] = min([energyMap(y-1,x), energyMap(y-1,x-1)]);
            if (minPos == 2)
                x = x - 1;
            end;
        else
            [minV, minPos] = min([energyMap(y-1,x-1), energyMap(y-1,x), energyMap(y-1,x+1)]);
            if (minPos == 1)
                x = x - 1;
            elseif (minPos == 3)
                x = x + 1;
            end;
        end;
        vertSeam(y) = x;
    end;
    
    % rest is for the first row; choose the pixel with minimum energy value
    y = 1;
    x = vertSeam(2);
    
    if (x == 1)
        [minV, minPos] = min([energyMap(y,x), energyMap(y,x+1)]);
        if (minPos == 2)
            x = x + 1;
        end;
    elseif (x == dimX)
        [minV, minPos] = min([energyMap(y,x), energyMap(y,x-1)]);
        if (minPos == 2)
            x = x - 1;
        end;
    else
        [minV, minPos] = min([energyMap(y,x), energyMap(y,x-1), energyMap(y,x+1)]);
        if (minPos == 2)
            x = x - 1;
        elseif (minPos == 3)
            x = x + 1;
        end;
    end;
    
    vertSeam(1) = x;
    