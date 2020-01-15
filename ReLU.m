function [ relu_out ] = ReLU( relu_in,backward )
% This function apply ReLU to given matrix
relu_zeroes=zeros(size(relu_in));

if backward
    relu_in(relu_in>0) = 1;
    relu_in(relu_in<=0) = 0;
    relu_out = relu_in;
else
    relu_out=max(relu_zeroes,relu_in);

end

end