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

%convolution function
filter = filterProducer(2, 5);
image = inpM(:,:,:,2);
[rowsI, colsI] = size(image);
[rowsF, colsF] = size(filter);

% Convolution
C = cnv(image,filter);
% MaxPooling
maxLayer = maxPool(C,size(filter));
% flatten maxLayer <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
% needs fixing to account for the
% maxLayer having multilayers now
F = reshape(maxLayer(:,:,1), [], 1);
[inputLayer,~] = size(F);
% initialize weights. Last elements on both rows are biases
% 
[W1,W2,bias] = initialize(inputLayer,3,3);
% add bias to F
F = [F;1];

Vhidden = F' * W1';
Vout = Vhidden;
Vhidden(11) = 1;
% Maybe transfer Function here after Vhidden

%Vout = Vhidden * W2';

% WHAT ?S THE PROBLEM HERE ?????????????????????????
y4 = exp(Vout(1))/(exp(Vout(1))+exp(Vout(2))+exp(Vout(3)));
y5 = exp(Vout(2))/(exp(Vout(1))+exp(Vout(2))+exp(Vout(3)));
y6 = exp(Vout(3))/(exp(Vout(1))+exp(Vout(2))+exp(Vout(3)));

% calc v1, v2, v3
% not sure if the transpose is needed/correct
mul1 = F' .* W1(1,:); 
v1 = sum(mul1, 'all');
mul2 = F' .* W1(2,:);
v2 = sum(mul2, 'all');
mul3 = F' .* W1(3,:);
v3 = sum(mul3, 'all');

% use softmax function
y1 = exp(v1)/(exp(v1)+exp(v2)+exp(v3));
y2 = exp(v2)/(exp(v1)+exp(v2)+exp(v3));
y3 = exp(v3)/(exp(v1)+exp(v2)+exp(v3));

% always gives y2 with 1 prob, others very very low



function r = filterProducer(size,number)
        A = zeros(size,size,number);
        for i = 1:number
            A(:,:,i)= randi(100,size)/100;
        end
        r = A;
end
