function [Sinput ,Shidden, Souts] = localGradientOut(correctClass,Yout,Vout,W1,W2)

v1=Vout(1);
v2=Vout(2);
v3=Vout(3);
y1=Yout(1);
y2=Yout(2);
y3=Yout(3);
S = (exp(v1)+exp(v2)+exp(v3));


% Sout1 = -(((-1)/y1)*((exp(v1)*(S-exp(v1))) / S^2));
% Sout2 = -(((-1)/y1)*(-(exp(v2)*(S-exp(v2))) / S^2));
% Sout3 = -(((-1)/y1)*(-(exp(v3)*(S-exp(v3))) / S^2));
%asdasda asdas aa a a a
if correctClass == 1
Sout1 = -(((-1)/y1)*((exp(v1)*(S-exp(v1))) / S^2));
Sout2 = -(((-1)/y1)*(-(exp(v1)*exp(v2)*exp(v3)) / S^2));
Sout3 = -(((-1)/y1)*(-(exp(v1)*exp(v2)*exp(v3)) / S^2));
end
if correctClass == 2
Sout1 = -(((-1)/y2)*(-(exp(v1)*exp(v2)*exp(v3)) / S^2));
Sout2 = -(((-1)/y2)*((exp(v2)*(S-exp(v2))) / S^2));
Sout3 = -(((-1)/y2)*(-(exp(v1)*exp(v2)*exp(v3)) / S^2));
end
if correctClass == 3
Sout1 = -(((-1)/y3)*(-(exp(v1)*exp(v2)*exp(v3))/ S^2));
Sout2 = -(((-1)/y3)*(-(exp(v1)*exp(v2)*exp(v3)) / S^2));
Sout3 = -(((-1)/y3)*((exp(v3)*(S-exp(v3))) / S^2));
end

Souts = [Sout1 Sout2 Sout3];
W2 = W2(:,1:10);
Shidden = W2' * Souts';
% apply same formula for the input layer 
Sinput = W1' * Shidden;


end