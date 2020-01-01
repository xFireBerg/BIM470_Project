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


image = inpM(:,:,:,2);
desired = 1 % for y1
% initialize -- we need to give the flatten matrix size as an input
[W1,W2,bias] = initialize(720,10,3);
% Forward 
[y1,y2,y3] = forward(W1,W2,bias,image);
error = 1-y1;

% always gives y2 with 1 prob, others very very low

