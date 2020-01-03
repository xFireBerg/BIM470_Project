function [convolved] = cnv(image,filter)

    padding = 0;
    strideConv = 1;
    [rowsI,~] = size(image);
    [rowsF,~,layersF] = size(filter);

    convolvedSize = ((rowsI+2*padding-rowsF)/strideConv)+1;
    C = zeros(convolvedSize, convolvedSize, layersF); 
    index = rowsI-(rowsF)+1;

    for layer = 1:layersF
%         filter = filter(:,:,layer);
%         C = C(:,:,layer);
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
