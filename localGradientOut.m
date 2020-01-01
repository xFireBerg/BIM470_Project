function [Sinput ,Shidden, Souts] = localGradientOut(correctClass,y1,y2,y3,v1,v2,v3,W1,W2)

S = (exp(v1)+exp(v2)+exp(v3));

if correctClass == 1
Sout1 = -(((-1)/y1)*((exp(v1)*(S-exp(v1))) / S^2));
Sout2 = -(((-1)/y1)*((exp(v2)*(S-exp(v2))) / S^2));
Sout3 = -(((-1)/y1)*((exp(v3)*(S-exp(v3))) / S^2));
end
if correctClass == 2
Sout1 = -(((-1)/y2)*(-(exp(v1)*exp(v2)) / S^2));
Sout2 = -(((-1)/y2)*((exp(v2)*(S-exp(v2))) / S^2));
Sout3 = -(((-1)/y2)*((exp(v3)*(S-exp(v3))) / S^2));
end
if correctClass == 3
Sout1 = -(((-1)/y3)*(-(exp(v1)*exp(v2)) / S^2));
Sout2 = -(((-1)/y3)*((exp(v2)*(S-exp(v2))) / S^2));
Sout3 = -(((-1)/y3)*((exp(v3)*(S-exp(v3))) / S^2));
end

Souts = [Sout1 Sout2 Sout3];
W2 = W2(:,1:10);
Shidden = W2' * Souts';
% apply same formula for the input layer 
Sinput = W1' * Shidden;


end