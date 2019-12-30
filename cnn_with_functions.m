clear all
clc

load('DesiredValuesVactor.mat');
load('images.mat');

% 
%img = inpM(:,:,5);
% imshow(img)


%%%%%%%%%Specify Training and Validation Sets,

XTrain = inpM(:,:,:,1:41);
XTest = inpM(:,:,:,41:60);

YTrain = desV(1:41);
YTrain=categorical(desV(1:41));
YTest = desV(41:60);

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
%     fullyConnectedLayer(3,'Name','fc1')
%     
%     softmaxLayer
%         
%     classificationLayer
%  ];

layers = [
    imageInputLayer([51 51 1])
    
    convolution2dLayer(3,3,'Padding','same')
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)

    
    fullyConnectedLayer(3)
    softmaxLayer
    classificationLayer];


%%%%%%%%%Specify Training Options
options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.001, ...
    'MaxEpochs',10, ...
    'Shuffle','every-epoch', ...
    'Verbose',false, ...
    'Plots','training-progress');
 
%  options = trainingOptions('sgdm', ...
%    'InitialLearnRate',0.01, ...
%    'MaxEpochs',10, ...
%    'Shuffle','every-epoch', ...
%    'ValidationData',{XTest,YTest}, ...
%    'ValidationFrequency',30, ...
%    'Verbose',false, ...
%    'Plots','training-progress');


%%%%%%%%%%%Train Network Using Training Data

net = trainNetwork(XTrain,YTrain,layers,options);
 
YPred = classify(net,XTest);
YValidation = categorical(YTest);

accuracy = sum(YPred == YValidation)/numel(YValidation)
 