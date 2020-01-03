function [Yout,Vout,maxLayer,F,filter,C] = forward(W,bias,image,filter)



%2- Convolution and maxpooling operations.
C = cnv(image,filter);
C = ReLU(C);
maxLayer = maxPool(C,size(filter));
% C = cnv(maxLayer,filter);
% maxLayer = maxPool(C,size(filter))

%3- Flatting with multi layer
f = flat(maxLayer);
F = [f;bias];% add bias to F

%4- Calculate the V
Vout = F' * W';
%Vout = sigmoidFunction(Vout);
Vout = Vout/100;

% Vhidden = F' * W1';
% % Apply transfer function sigmoid
% Vhidden = sigmoidFunction(Vhidden);
% % Add bias
% Vhidden(11) = bias;
% 
% Vout = Vhidden * W2';


y1 = exp(Vout(1))/(exp(Vout(1))+exp(Vout(2))+exp(Vout(3)));
y2 = exp(Vout(2))/(exp(Vout(1))+exp(Vout(2))+exp(Vout(3)));
y3 = exp(Vout(3))/(exp(Vout(1))+exp(Vout(2))+exp(Vout(3)));

Yout = [y1 y2 y3];


end

% always gives y2 with 1 prob, others very very low