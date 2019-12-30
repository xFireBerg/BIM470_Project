clear all
clc

load('DesiredValuesVactor.mat');
load('images.mat');
% 
 img = inpM(:,:,:,5); %horizontal rectangle 
% img2 = inpM(:,:,35); %vertical rectangle
% img3 = inpM(:,:,55); %circle
% 
imshow(img)


%%%%%%%%%Specify Training and Validation Sets,

XTrain = inpM(:,:,:,1:41);
% inpTrain = num2cell(inpTrain);
XTest = inpM(:,:,:,41:60);

%XTest = num2cell(XTest);

YTrain = desV(1:41);
%desTrain = desTrain.';
YTest = desV(41:60);



YTrain = num2cell(YTrain);
%C = categories(YTrain)
%%%%%%%%%Define Network Architecture

% layers = [
%     imageInputLayer([51 51 1])
%     
%     convolution3dLayer(5,16,'Stride',4)
%     
%     maxPooling3dLayer(2,'Stride',2)
%     
%     flattenLayer('Name','flatten1')
%    
%     fullyConnectedLayer(10,'Name','fc1')
%     
%     softmaxLayer
%         
%      classificationLayer
%  ];

layers = [
    imageInputLayer([51 51 1])
    
    convolution2dLayer(3,8,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,16,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,32,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    fullyConnectedLayer(10)
    softmaxLayer
    classificationLayer];


%%%%%%%%%Specify Training Options
options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.001, ...
    'MaxEpochs',4, ...
    'Verbose',false, ...
    'Plots','training-progress');
 
%  options = trainingOptions('sgdm', ...
%    'InitialLearnRate',0.01, ...
%    'MaxEpochs',4, ...
%    'Shuffle','every-epoch', ...
%    'ValidationData',{XTest,YTest}, ...
%    'ValidationFrequency',30, ...
%    'Verbose',false, ...
%    'Plots','training-progress');


%%%%%%%%%%%Train Network Using Training Data

 net = trainNetwork(XTrain,YTrain,layers,options);