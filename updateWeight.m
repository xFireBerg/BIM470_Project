function [W1,W2] = updateWeight(W1,W2,Shidden,Souts,flatten,Vhidden,lr)
% lr is learningRate
W2 = W2+(lr*Souts'*Vhidden);
W1 = W1+(lr*Shidden*flatten');
end