function [W,bias] = initialize(inputLayerSize,outputLayerSize)

rng(3);
% create a (filterNum*(625+1)) matrix of random ints
W = randi([-1000 1000], outputLayerSize, inputLayerSize+1)/10000;
bias = 1;

end
