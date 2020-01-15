function [Sinput, Souts] = localGradientOut(correctClass,Yout,Vout,W)

% This function is for calculating the local gradients
% Sout   is local gradient of output neuron
% Sinput is local gradient of input neruon - flatten layer


v1=Vout(1);
v2=Vout(2);
v3=Vout(3);
y1=Yout(1);
y2=Yout(2);
y3=Yout(3);
% To make simple, we accept S as the sum of all exp(v)
S = (exp(v1)+exp(v2)+exp(v3));


% Find the local gradient by applying formula 
if correctClass == 1
Sout1 = -(((-1)/y1)*((exp(v1)*(S-exp(v1))) / S^2));
Sout2 = -(((-1)/y1)*(-(exp(v1)*exp(v2)) / S^2));
Sout3 = -(((-1)/y1)*(-(exp(v1)*exp(v3)) / S^2));
end
if correctClass == 2
Sout1 = -(((-1)/y2)*(-(exp(v2)*exp(v1)) / S^2));
Sout2 = -(((-1)/y2)*((exp(v2)*(S-exp(v2))) / S^2));
Sout3 = -(((-1)/y2)*(-(exp(v2)*exp(v3)) / S^2));
end
if correctClass == 3
Sout1 = -(((-1)/y3)*(-(exp(v3)*exp(v1))/ S^2));
Sout2 = -(((-1)/y3)*(-(exp(v3)*exp(v2)) / S^2));
Sout3 = -(((-1)/y3)*((exp(v3)*(S-exp(v3))) / S^2));
end


Souts = [Sout1 Sout2 Sout3];
%Souts = round(Souts,7);

% Calculate the Sinput-Flaten
[row,col] = size(W);
W = W(:,1:col-1);
% apply formula for the input layer 
Sinput = W' * Souts';




end