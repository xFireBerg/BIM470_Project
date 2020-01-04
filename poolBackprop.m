function [max_backprop] = poolBackprop(maxLayer,F)

    % This function for backprob the maxPooling layer
    % Take the local gradient from Sinput-Flatten layer to maxPool Layer
    % (Backprob) Flatten --> maxPool Later

    % Shape of maxPool
    [row,col,filterNum] = size(maxLayer);
    % maxPool has 2 type of layer
    % 1 for values and 1 for index of values
    % so to find the real filter number we divide by 2
    filterNum = filterNum/2;  
    

    for i = 1:filterNum %
        % Indexes is for where should we put these maxLayer values in the
        % flatten array
        startIndex = (row*col*(i-1))+1;
        lastIndex = (row*col*i);
        % odd index has values
        % even index has indexes of maxLayer's value
        filtIndex = (2*i)-1;
        maxLayer(:,:,filtIndex) = reshape(F(startIndex:lastIndex),[row,col]);
    end
    max_backprop = maxLayer;
    
end
