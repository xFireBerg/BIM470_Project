clc 
clear all

load('DesiredValuesVactor.mat');
load('images.mat');
load('test_images.mat');

% Suffled List for training
list = zeros(60,1);
for a = 1:60
    list(a,1) = a;
end
list=list(randperm(length(list)));


XTrain = zeros(51,51,40);
XValidation = zeros(51,51,20);
YTrain = zeros(40,1);
YValidation = zeros(20,1);


% Split data to Train and Test - randomly
for i = 1:60
    if i<=40
        random = list(i);
        XTrain(:,:,i) = inpM(:,:,random);
        YTrain(i) = desV(random);
        
    else
        random = list(i);
        i = i-40;
        XValidation(:,:,i) = inpM(:,:,random);
        YValidation(i) = desV(random);
        
    end
    
   
end


% Parameters
% We are getting best result with these parameters (acc = 0.75)
% Accuracy can change for each train.
learningRate = 0.0008;
epochNum = 15;
filterNum = 5;
% initialize
[W,bias] = initialize(625*filterNum,3);
% Define Filter
filter = filterProducer(2, filterNum);


%------------------------------- Train -------------------------------

for j = 1:epochNum
    %[XTrain,YTrain,XValidation,YValidation,list] = suffle(XTrain,YTrain,XValidation,YValidation,inpM,desV);
    
    for i = 1:40
        image = XTrain(:,:,i);
        class = YTrain(i,1);


        % Forward Operation
        [Yout,Vout,maxLayer,F,filter,C] = forward(W,bias,image,filter);
        % Find Local Gradients
        [Sinput,Souts] = localGradientOut(class,Yout,Vout,W);
        % Update Weights
        [WW] = updateWeight(W,Souts,F,learningRate);
        % Move local gradients to maxpool layer
        [max_backprop] = poolBackprop(maxLayer,Sinput);
        % Move local gradients to convolved img
        [convBack] = poolToCnv(C,max_backprop,size(filter));
        % Update Filters
        [updatedFilter] = updateFilter(image,convBack,filter,learningRate);
        % Assign updated values
        filter = updatedFilter;
        W = WW;
    end
    
    % Print the accuracy for the epoch   
    [acc, correct, wrong] = testAcc(XValidation,YValidation,W,filter);
    X = ['----- Epcoch -  [',num2str(epochNum),':',num2str(j),']    Acc -  ',num2str(acc),' Correct : ',num2str(correct),' Wrong : ',num2str(wrong)];
    disp(X)
end

% ------------------------------- Test -------------------------------
[acc, correct, wrong] = testAcc(XValidation,YValidation,W,filter);
disp(".")
disp(".")
disp(" -------------------- Validation -------------------- ")
X = [' Acc -  ',num2str(acc),' Correct : ',num2str(correct),' Wrong : ',num2str(wrong)];
disp(X)
disp(".")
disp(".")
disp(" -------------------- TEST -------------------- ")
predicted = predict(test,W,filter);

% To suffle data ( We are not using this function now) 
function [XTrain,YTrain,XValidation,YValidation,list] = suffle(XTrain,YTrain,XValidation,YValidation,inpM,desV)
    
    list = zeros(60,1);
    for a = 1:60
        list(a,1) = a;
    end
    list=list(randperm(length(list)));
    for i = 1:60
        if i<=40
            random = list(i);
            XTrain(:,:,i) = inpM(:,:,random);
            YTrain(i) = desV(random);

        else
            random = list(i);
            i = i-40;
            XValidation(:,:,i) = inpM(:,:,random);
            YValidation(i) = desV(random);

        end

   
    end

end



