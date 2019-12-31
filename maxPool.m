function [pooled] = maxPool(image,filterSize)

    % ASSUME THAT POOLING STRIDE IS EQUAL TO FILTER SIZE
    stridePool = filterSize;
    [rowsI,~] = size(image);
    pooledSize = ((rowsI-stridePool)/stridePool)+1;
    % operations for maxpooling C layer using window size 2*2 and stride 2
    maxLayer = zeros(pooledSize, pooledSize, stridePool); % maxpool layer
    index = (pooledSize*filterSize)-(filterSize-1);
    i = 1;
    for row = 1:2:index
        j = 1;
        for col = 1:2:index
            window = image(row:row+(filterSize-1), col:col+(filterSize-1)); % sliding window
            [maxElement, maxIdx] = max(window, [], 'all', 'linear'); % find max of window with idx
            maxLayer(i, j, 1) = maxElement; % set max elements on first 'page'
            maxLayer(i,j,2) = maxIdx; % set max element idx on second 'page'
            j = j + 1; 
        end
        i = i + 1;
    end
    pooled = maxLayer;
end