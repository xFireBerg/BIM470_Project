function [pooled] = maxPool(C,filterDimensions)
    
    % ASSUME THAT POOLING STRIDE IS EQUAL TO FILTER SIZE
    stridePool = filterDimensions(1);
    filterSize = filterDimensions(2); %always same as stridePool
    layers = filterDimensions(3);
    
    [rowsI,~] = size(C);
    pooledSize = ((rowsI-stridePool)/stridePool)+1;
    % operations for maxpooling C layer using window size 2*2 and stride 2
    % 3rd dimension is double the layers of filters, because after every
    % layer, the second layer stores the indexes, used for backpropagation
    maxLayer = zeros(pooledSize, pooledSize, 2*layers); % maxpool layer
    index = (pooledSize*filterSize)-(filterSize-1);
    for layer = 1:2:layers*2  
        i = 1;
        for row = 1:2:index
            j = 1;
            for col = 1:2:index
                window = C(row:row+(filterSize-1), col:col+(filterSize-1)); % sliding window
                [maxElement, maxIdx] = max(window, [], 'all', 'linear'); % find max of window with idx
                maxLayer(i, j, layer) = maxElement; % set max elements on first 'page'
                maxLayer(i,j,layer+1) = maxIdx; % set max element idx on second 'page'
                j = j + 1; 
            end
            i = i + 1;
        end
        pooled = maxLayer;
    end
end