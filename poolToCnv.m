function [convBack] = poolToCnv(CC,max_backprop,filterDimensions)

    % This function is for backprop 
    % Maxpooling layet --> Convolved
    %

    % ASSUME THAT POOLING STRIDE IS EQUAL TO FILTER SIZE
    stridePool = filterDimensions(1);
    filterSize = filterDimensions(2); %always same as stridePool
    layers = filterDimensions(3);
    
    [rowsI,colsI,layerI] = size(CC);
    pooledSize = ((rowsI-stridePool)/stridePool)+1;
    % operations for maxpooling C layer using window size 2*2 and stride 2
    % 3rd dimension is double the layers of filters, because after every
    % layer, the second layer stores the indexes, used for backpropagation
    C = zeros(rowsI, colsI,layerI); % maxpool layer
    index = (pooledSize*filterSize)-(filterSize-1);
    cnvLayer = 1;
    for layer = 1:2:layers*2
        i = 1;
        for row = 1:2:index
            j = 1;
            for col = 1:2:index
               
                indx = max_backprop(i,j,layer+1);%index of 
                value = max_backprop(i,j,layer);
                 
                window = C(row:row+(filterSize-1), col:col+(filterSize-1),cnvLayer);
                window(indx) = value;
                C(row:row+(filterSize-1),col:col+(filterSize-1),cnvLayer) = window;
                j = j + 1; 
            end
            i = i + 1;
        end
        cnvLayer = cnvLayer+1;
        
    end
    
    % When we are doing forward, we are using ReLU after convolution
    % So, apply ReLU for backprob to.
    C = ReLU(C);
    convBack=C;
    
        


end