function [convolved] = cnv(image,filter)

    % This function is for convolution operation
    % We have img and filter
    
    % define the parameters
    padding = 0;
    strideConv = 1;
    % get the size of image and filter
    [rowsI,~] = size(image);
    [rowsF,~,layersF] = size(filter);
    %Calculate the size of convolved img so we can make an empty array with
    %these sizes
    convolvedSize = ((rowsI+2*padding-rowsF)/strideConv)+1;
    C = zeros(convolvedSize, convolvedSize, layersF);
    % index for go through rows and columns
    index = rowsI-(rowsF)+1;

    % Firs loop is for iterating the layers of filter 
    % We have multiple filter so, we do same conv operation for each.
    for layer = 1:layersF
        % get rows and columns
        for row = 1:index
            for col = 1:index
                window = image(row:row+(rowsF-1), col:col+(rowsF-1));
                multiple = window.*filter(:,:,layer); %element-wise multiplication
                theSum = sum(multiple, 'all'); %sum of all elements within window
                C(row,col,layer) = theSum; 
            end
        end
        convolved = C;
    end
end
