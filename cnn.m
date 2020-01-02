clc 
clear all

load('DesiredValuesVactor.mat');
load('images.mat');

% Split Data
XTrain = inpM(:,:,:,1:41);
XTest = inpM(:,:,:,41:60);
YTrain = desV(1:41);
YTest = desV(41:60);
YTrain = num2cell(YTrain);

%----------------------------------------------------

learningRate = 0.1;
% initialize -- we need to give the flatten matrix size as an input
[W1,W2,bias] = initialize(3125,10,3);
%1- Filter
filter = filterProducer(2, 5);
class = 1;
for i = 1:60
disp(i);
j = mod(i,20);
image = inpM(:,:,:,i);

if (i >= 20)
    class = 1;
elseif (i > 20) && (i<=40)
    class = 2;
else
    class = 3;
end

% Forward 
[Yout,Vhidden,Vout,maxLayer,F,filter,C] = forward(W1,W2,bias,image,filter);
%disp(Yout);
[Sinput,Shidden,Souts] = localGradientOut(class,Yout,Vout,W1,W2);
%Vhidden = Vhidden(1:10);
disp(Souts);
[WW1,WW2] = updateWeight(W1,W2,Shidden,Souts,F,Vhidden,learningRate);

[max_backprop] = poolBackprop(maxLayer,Sinput);

[convBack] = poolToCnv(C,max_backprop,size(filter));

[updatedFilter] = updateFilter(image,convBack,filter,learningRate);
filter = updatedFilter;
W1 = WW1;
W2 = WW2;

end

% image = inpM(:,:,:,2);
% learningRate = 0.1;
% % initialize -- we need to give the flatten matrix size as an input
% [W1,W2,bias] = initialize(3125,10,3);
% % Forward 
% [Yout,Vhidden,Vout,maxLayer,F,filter,C] = forward(W1,W2,bias,image);
% 
% [Sinput,Shidden,Souts] = localGradientOut(1,Yout,Vout,W1,W2);
% %Vhidden = Vhidden(1:10);
% 
% [WW1,WW2] = updateWeight(W1,W2,Shidden,Souts,F,Vhidden,learningRate);
% 
% [max_backprop] = poolBackprop(maxLayer,Sinput);
% 
% [convBack] = poolToCnv(C,max_backprop,size(filter));
% 
% [updatedFilter] = updateFilter(image,convBack,filter,learningRate);

% always gives y2 with 1 prob, others very very low

