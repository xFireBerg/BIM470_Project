function [W1,W2,bias] = initialize(inputLayerSize,hiddenLayerSize,outputLayerSize)

rng(3);
% create a 3*626 matrix of random ints between -5:5
W1 = randi([1 100], hiddenLayerSize, inputLayerSize+1)/100;
W2 = randi([1 100], outputLayerSize, hiddenLayerSize+1)/100;
bias = 1;

end
