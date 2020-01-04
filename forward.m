function [Yout,Vout,maxLayer,F,filter,C] = forward(W,bias,image,filter)

% This function doin forward operation.

% Convolution and maxpooling operations.
C = cnv(image,filter);
C = ReLU(C);
maxLayer = maxPool(C,size(filter));


% Flatting with multi layer
f = flat(maxLayer);
% Add bias to F
F = [f;bias];

% Calculate the Vout
Vout = F' * W';
% Transfer Function
%Vout = sigmoidFunction(Vout);
Vout = Vout/1000;

% Softmax 
y1 = exp(Vout(1))/(exp(Vout(1))+exp(Vout(2))+exp(Vout(3)));
y2 = exp(Vout(2))/(exp(Vout(1))+exp(Vout(2))+exp(Vout(3)));
y3 = exp(Vout(3))/(exp(Vout(1))+exp(Vout(2))+exp(Vout(3)));

% Return outputs
Yout = [y1 y2 y3];


end

