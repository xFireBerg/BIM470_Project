function [convolved] = cnv(image,filter)

    padding = 0;
    strideConv = 1;
    [rowsI,colsI] = size(image);
    [rowsF,colsI] = size(filter);

    convolvedSize = ((rowsI+2*padding-rowsF)/strideConv)+1;
    C = zeros(convolvedSize, convolvedSize); 
    index = convolvedSize-(rowsF-1);

    for row = 1:index
        for col = 1:index
            window = image(row:row+(rowsF-1), col:col+(rowsF-1));
            multiple = window.*filter; %element-wise multiplication
            theSum = sum(multiple, 'all'); %sum of all elements within window
            C(row,col) = theSum; 
        end
    end
    convolved = C;
end
