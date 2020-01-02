function [max_backprop] = poolBackprop(maxLayer,F)

    [row,col,filterNum] = size(maxLayer);
    filterNum = filterNum/2;  
    

    for i = 1:filterNum %
        % Indexes is for where should we put these maxLayer values in the
        % flatten array
        startIndex = (row*col*(i-1))+1;
        lastIndex = (row*col*i);
        filtIndex = (2*i)-1;
        %F(startIndex:lastIndex) = reshape(maxLayer(:,:,filtIndex), [], 1);
        maxLayer(:,:,filtIndex) = reshape(F(startIndex:lastIndex),[row,col]);
    end
    max_backprop = maxLayer;
    
end
