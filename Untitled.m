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

% operations for creating a convolution layer from a single image and
% filter with window size 2*2 and stride 1
for row = 1:49
    for col = 1:49
        window = image(row:row+1, col:col+1);
        multiple = window.*filter; %element-wise multiplication
        theSum = sum(multiple, 'all'); %sum of all elements within window
        C(row,col) = theSum; 
    end
end

% operations for maxpooling C layer using window size 2*2 and stride 2
maxLayer = zeros(25, 25, 2); % maxpool layer
i = 1;
for row = 1:2:49
    j = 1;
    for col = 1:2:49
        window = C(row:row+1, col:col+1); % sliding window
        [maxElement, maxIdx] = max(window, [], 'all', 'linear'); % find max of window with idx
        maxLayer(i, j, 1) = maxElement; % set max elements on first 'page'
        maxLayer(i,j,2) = maxIdx; % set max element idx on second 'page'
        j = j + 1; 
    end
    i = i + 1;
end


        