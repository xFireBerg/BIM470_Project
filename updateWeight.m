function [W] = updateWeight(W,Souts,flatten,lr)
% lr is learningRate
% update weights by using formula
W = W+(lr*(Souts'*flatten'));

end