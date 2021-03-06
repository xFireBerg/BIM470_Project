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
image = inpM(:,:,:,42);
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

% flatten maxLayer
F = reshape(maxLayer(:,:,1), [], 1);
% initialize weights. Last elements on both rows are biases
% for consistent random num generation
rng(1);
% create a 3*626 matrix of random ints between -5:5
W = randi([-5 5], 3, 626);
% add bias to F
F = [F;1];

% calc v1, v2, v3
% not sure if the transpose is needed/correct
mul = F' .* W(1,:); 
v1 = sum(mul, 'all');
mul = F' .* W(2,:);
v2 = sum(mul, 'all');
mul = F' .* W(3,:);
v3 = sum(mul, 'all');

% use softmax function
y1 = exp(v1)/(exp(v1)+exp(v2)+exp(v3));
y2 = exp(v2)/(exp(v1)+exp(v2)+exp(v3));
y3 = exp(v3)/(exp(v1)+exp(v2)+exp(v3));

% always gives y2 with 1 prob, others very very low