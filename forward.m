function [y1,y2,y3] = forward(W1,W2,bias,input)

image = input;

%1- Filter
filter = filterProducer(2, 5);


%2- Convolution and maxpooling operations.
C = cnv(image,filter);
C = ReLU(C);
maxLayer = maxPool(C,size(filter));
% C = cnv(maxLayer,filter);
% maxLayer = maxPool(C,size(filter))

%3- Flatting with multi layer
f = flat(maxLayer);
F = [f;1];% add bias to F

%4- Calculate the V
Vhidden = F' * W1';
% Apply transfer function sigmoid
Vhidden = sigmoidFunction(Vhidden);
% Add bias
Vhidden(11) = 1;

Vout = Vhidden * W2';


y1 = exp(Vout(1))/(exp(Vout(1))+exp(Vout(2))+exp(Vout(3)));
y2 = exp(Vout(2))/(exp(Vout(1))+exp(Vout(2))+exp(Vout(3)));
y3 = exp(Vout(3))/(exp(Vout(1))+exp(Vout(2))+exp(Vout(3)));

% This is just for seeing the result
% we should use localGradientOut in an appropriate place
[Souts,Shidden] = localGradientOut(1,y1,y2,y3,Vout(1),Vout(2),Vout(3),W2);
%Vhidden = Vhidden(1:10);

[WW1,WW2] = updateWeight(W1,W2,Shidden,Souts,F,Vhidden,0.1);




end

% always gives y2 with 1 prob, others very very low