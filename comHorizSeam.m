
function horizSeam = findHorizSeam(energyMap)
    [dimY, dimX] = size(energyMap);
    horizSeam = zeros(1,dimX);
    [minV, minRow] = min(energyMap(:,dimX));
    y = minRow;
    horizSeam(dimX) = y;
    
    % start from the last column with the smallest value in the accumulated 
    % energy map, then for each pixel, choose the connected pixel that has 
    % the minimum value
    for x=dimX-1:-1:2
        if (y == 1)
            [minV, minPos] = min([energyMap(y,x-1), energyMap(y+1,x-1)]);
            if (minPos == 2)
                y = y + 1;
            end;
        elseif (y == dimY)
            [minV, minPos] = min([energyMap(y,x-1), energyMap(y-1,x-1)]);
            if (minPos == 2)
                y = y - 1;
            end;
        else
            [minV, minPos] = min([energyMap(y,x-1), energyMap(y-1,x-1), energyMap(y+1,x-1)]);
            if (minPos == 2)
                y = y - 1;
            elseif (minPos == 3)
                y = y + 1;
            end;
        end;
        horizSeam(x) = y;
    end;
    
    % rest is for the first column; choose the pixel with minimum energy value
    x = 1;
    y = horizSeam(2);
    
    if (y == 1)
        [minV, minPos] = min([energyMap(y,x), energyMap(y+1,x)]);
        if (minPos == 2)
            y = y + 1;
        end;
    elseif (y == dimY)
        [minV, minPos] = min([energyMap(y,x), energyMap(y-1,x)]);
        if (minPos == 2)
            y = y - 1;
        end;
    else
        [minV, minPos] = min([energyMap(y,x), energyMap(y-1,x), energyMap(y+1,x)]);
        if (minPos == 2)
            y = y - 1;
        elseif (minPos == 3)
            y = y + 1;
        end;
    end;
    
    horizSeam(1) = y;