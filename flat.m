function [flat] = flat(maxLayer)

    
    [row,col,filterNum] = size(maxLayer)
    filterNum = filterNum/2;  
    fSize = row*col*filterNum;
    F = zeros(fSize,1); 

    for i = 1:filterNum %
        % Indexes is for where should we put these maxLayer values in the
        % flatten array
        startIndex = (row*col*(i-1))+1;
        lastIndex = (row*col*i);
        filtIndex = (2*i)-1;
        F(startIndex:lastIndex) = reshape(maxLayer(:,:,filtIndex), [], 1);

    end

    flat=F;

end
