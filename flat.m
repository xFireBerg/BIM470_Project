function [flat] = flat(maxLayer)

    % This function is for flatting operation
    % MaxLayer --> Flatten Layer
    
    [row,col,filterNum] = size(maxLayer);
    % maxLayer has 2 type of layer
    % 1 for values and 1 for index of values
    % so to find the real filter number we divide by 2
    filterNum = filterNum/2; 
    % find the size of flatten layer
    fSize = row*col*filterNum;
    % empty flatten array
    F = zeros(fSize,1); 

    for i = 1:filterNum %
        % Indexes is for where should we put these maxLayer values in the
        % flatten array
        startIndex = (row*col*(i-1))+1;
        lastIndex = (row*col*i);
        % odd index has values
        % even index has indexes of maxLayer's value
        filtIndex = (2*i)-1;
        % put the values to Flatten from maxLayer
        F(startIndex:lastIndex) = reshape(maxLayer(:,:,filtIndex), [], 1);

    end
    
    % return
    flat=F;

end
