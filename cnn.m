clc 
clear all

load('DesiredValuesVactor.mat');
load('images.mat');

% Split Data
XTrain = inpM(:,:,:,1:41);
XTest = inpM(:,:,:,41:60);
YTrain = desV(1:41);
YTest = desV(41:60);
YTrain = num2cell(YTrain);

%----------------------------------------------------

%convolution function
filter = filterProducer(2);
image = inpM(:,:,:,42);
[rowsI, colsI] = size(image);
[rowsF, colsF] = size(filter);

% Convolution
C = cnv(image,filter);
% MaxPooling
maxLayer = maxPool(C,2);
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



function r = filterProducer(size)
        A = zeros(size,size);
        A(:,:)= randi(100,size)/100;
        r = A;
      end
