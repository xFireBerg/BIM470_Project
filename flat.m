function [flat] = flat(maxLayer)

    
    [row,col,filterNum] = size(maxLayer)
    filterNum = filterNum/2;  
    fSize = row*col*filterNum;
    F = zeros(fSize,1); 

    for i = 1:filterNum % 1 3 5 7 9
        start = (row*col*(i-1))+1;
        last = (row*col*i);
        filtIndex = (2*i)-1;
        a = reshape(maxLayer(:,:,filtIndex), [], 1);
        b = F(start:last);
        F(start:last) = reshape(maxLayer(:,:,filtIndex), [], 1);

    end

    flat=F;

end
