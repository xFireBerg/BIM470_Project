load('DesiredValuesVactor.mat');
load('images.mat');

hFilter = [0, 0; 
           1, 1]; 
           
vFilter = [0, 1;
           0, 1];
       
cFilter1 = [0, 1;
            1, 0];
        
cFilter2 = [1, 0;
            0, 1];

XTrain = inpM(:,:,:,1:41);
% inpTrain = num2cell(inpTrain);
XTest = inpM(:,:,:,41:60);

YTrain = desV(1:41);
%desTrain = desTrain.';
YTest = desV(41:60);

YTrain = num2cell(YTrain);


%convolution function
filter = hFilter;
image = inpM(:,:,:,1);
C = zeros(50, 50); %needs to change according to image, filter, and stride size
[rowsI, colsI] = size(image);
[rowsF, colsF] = size(filter);
%img = zeros(2, 2);
%for horizontal stride
%sum(1,1) = image(1,1)*filter(1,1) + image(1,2)*filter(1,2) + image(2,1)*filter(2,1) + image(2,2)*filter(2,2);

% operations for first element of the convolution layer
% window = image(1:2, 1:2);
% multiple = window.*filter;
% theSum = sum(multiple, 'all');
% C(1,1) = theSum;

for row = 1:49
    for col = 1:49
        window = image(row:row+1, col:col+1);
        multiple = window.*filter;
        theSum = sum(multiple, 'all');
        C(row,col) = theSum;
    end
end

