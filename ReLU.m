function [ relu_out ] = ReLU( relu_in )
% This function apply ReLU to given matrix
relu_zeroes=zeros(size(relu_in));
relu_out=max(relu_zeroes,relu_in);
end