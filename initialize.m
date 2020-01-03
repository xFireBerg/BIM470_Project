function [W,bias] = initialize(inputLayerSize,outputLayerSize)

rng(3);
% create a 3*626 matrix of random ints between -5:5
%W1 = randi([1 100], hiddenLayerSize, inputLayerSize+1)/100;
W = randi([-100 100], outputLayerSize, inputLayerSize+1)/1000;
bias = 1;

end
