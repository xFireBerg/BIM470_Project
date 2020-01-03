clc 
clear all

load('DesiredValuesVactor.mat');
load('images.mat');

% Suffled List for training
list = zeros(60,1);
for a = 1:60
    list(a,1) = a;
end
list=list(randperm(length(list)));

XTrain = zeros(51,51,1,40);
XTest = zeros(51,51,1,20);
YTrain = zeros(40,1);
YTest = zeros(20,1);



for i = 1:60
    if i<=40
        random = list(i);
        XTrain(:,:,:,i) = inpM(:,:,:,random);
        YTrain(i) = desV(random);
        
    else
        random = list(i);
        i = i-40;
        XTest(:,:,:,i) = inpM(:,:,:,random);
        YTest(i) = desV(random);
        
    end
    
   
end

% Split Data
% XTrain = inpM(:,:,:,1:41);
% XTest = inpM(:,:,:,41:60);
% YTrain = desV(1:41);
% YTest = desV(41:60);
% YTrain = num2cell(YTrain);

%----------------------------------------------------

learningRate = 0.001;
epochNum = 7;
filterNum = 5;
% initialize -- we need to give the flatten matrix size as an input
[W,bias] = initialize(625*filterNum,3);
%1- Filter
filter = filterProducer(2, filterNum);




for j = 1:epochNum

    
    for i = 1:40
        image = XTrain(:,:,:,i);
        class = YTrain(i,1);


        % Forward 
        [Yout,Vout,maxLayer,F,filter,C] = forward(W,bias,image,filter);

        [Sinput,Souts] = localGradientOut(class,Yout,Vout,W);

        [WW] = updateWeight(W,Souts,F,learningRate);

        [max_backprop] = poolBackprop(maxLayer,Sinput);

        [convBack] = poolToCnv(C,max_backprop,size(filter));

        [updatedFilter] = updateFilter(image,convBack,filter,learningRate);
        filter = updatedFilter;
        W = WW;
    end

    [acc, correct, wrong] = test(XTest,YTest,W,filter);
    X = ['----- Epcoch -  ',num2str(j),'    Acc -  ',num2str(acc),' Correct : ',num2str(correct),' Wrong : ',num2str(wrong)];
    disp(X)
end

[acc, correct, wrong] = test(XTest,YTest,W,filter);
disp("")
disp(" -------------------- TEST -------------------- ")
X = [' Acc -  ',num2str(acc),' Correct : ',num2str(correct),' Wrong : ',num2str(wrong)];
disp(X)






