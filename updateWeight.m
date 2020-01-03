function [W] = updateWeight(W,Souts,flatten,lr)
% lr is learningRate

W = W+(lr*(Souts'*flatten'));
% disp("Wwwwww");
% disp(W(:,1:10))
end