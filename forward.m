function [y1,y2,y3] = forward(W1,W2,bias,input)

image = input;

%1- Filter
filter = filterProducer(2, 5);


%2- Convolution and maxpooling operations.
C = cnv(image,filter);
C = ReLU(C);
maxLayer = maxPool(C,size(filter));
C = cnv(maxLayer,filter);
maxLayer = maxPool(C,size(filter));

%3- Flatting with multi layer
F = flat(maxLayer);
F = [F;1];% add bias to F

%4- Calculate the V
Vhidden = F' * W1';% TRANSFER FUNCTÝON HERE !!!
Vhidden(11) = 1;
Vout = Vhidden * W2';

% WHAT IS THE PROBLEM HERE ?????????????????????????
y1 = exp(Vout(1))/(exp(Vout(1))+exp(Vout(2))+exp(Vout(3)));
y2 = exp(Vout(2))/(exp(Vout(1))+exp(Vout(2))+exp(Vout(3)));
y3 = exp(Vout(3))/(exp(Vout(1))+exp(Vout(2))+exp(Vout(3)));

end

% always gives y2 with 1 prob, others very very low