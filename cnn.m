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

learningRate = 0.01;
% initialize -- we need to give the flatten matrix size as an input
[W,bias] = initialize(3125,3);
%1- Filter
filter = filterProducer(2, 5);
class = 1;
correct1 = 0;
wrong1 = 0;
for j = 1:3
    
    for i = 1:60
        disp(i);

        image = inpM(:,:,:,i);

        if (i <= 20)
            class = 1;
        end
        if (i > 20) && (i<=40)
            class = 2;
        end
        if (i > 40) && (i<=60)
            class = 3;
        end

        % Forward 
        [Yout,Vout,maxLayer,F,filter,C] = forward(W,bias,image,filter);
%          disp("Vout")
%          disp(Vout)
%         disp("Yout")
%         disp(Yout);

         
        if (class == 1 && j == 3)
            if (Yout(1)>Yout(2)) && (Yout(1)>Yout(3))
                disp("Class-1 CORRECT")
                correct1 = correct1+1;

            else
                disp("Class-1 WRONG  @@@")
                wrong1 = wrong1+1;
            end

        end
        if (class == 2 && j == 3 )
            if (Yout(2)>Yout(3)) && (Yout(2)>Yout(1))
                disp("Class-2 CORRECT")
                correct1 = correct1+1;

            else
                disp("Class-2 WRONG  @@@")
                wrong1 = wrong1+1;            
            end
            
        end
        if (class == 3 && j == 3 )
            if (Yout(3)>Yout(2)) && (Yout(3)>Yout(1))
                disp("Class-3 CORRECT")
                correct1 = correct1+1;

            else
                disp("Class-3 WRONG  @@@")
                wrong1 = wrong1+1;            

            end
            
        end

        [Sinput,Souts] = localGradientOut(class,Yout,Vout,W);
        %Vhidden = Vhidden(1:10);
         disp("Sout");
         disp(Souts);
%         disp("Sinput");
%         disp(Sinput(1:10));
        [WW] = updateWeight(W,Souts,F,learningRate);

        [max_backprop] = poolBackprop(maxLayer,Sinput);

        [convBack] = poolToCnv(C,max_backprop,size(filter));

        [updatedFilter] = updateFilter(image,convBack,filter,learningRate);
        filter = updatedFilter;
%         disp("updatedFilter")
%         disp(filter(:,:,2));
%         disp("Updated W ")
%         disp(W(1,1:19));
%         disp("Updated F ")
%         disp(F(1:10));
        W = WW;
    end


end

correct = 0;
wrong = 0;
% for i = 1:20
% [Yout,Vout,maxLayer,F,filter,C] = forward(W,bias,inpM(:,:,:,i),filter);
% if (Yout(1)>Yout(2)) && (Yout(1)>Yout(3))
%     disp("Class-1 CORRECT")
%     correct = correct+1;
%     disp(Yout);
% else
%     disp("Class-1 WRONG  @@@")
%     wrong = wrong+1;
%     disp(Yout);
% end
% end
% for i = 21:40
% [Yout,Vout,maxLayer,F,filter,C] = forward(W,bias,inpM(:,:,:,i),filter);
% if (Yout(2)>Yout(1)) && (Yout(2)>Yout(3))
%     disp("Class-2 CORRECT")
%     correct = correct+1;
%     disp(Yout);
% else
%     disp("Class-2 WRONG  @@@")
%     wrong = wrong+1;
%     disp(Yout);
% end
% end
% for i = 41:60
% [Yout,Vout,maxLayer,F,filter,C] = forward(W,bias,inpM(:,:,:,i),filter);
% if (Yout(3)>Yout(2)) && (Yout(3)>Yout(1))
%     disp("Class-3 CORRECT")
%     correct = correct+1;
%     disp(Yout);
% else
%     disp("Class-3 WRONG  @@@")
%     wrong = wrong+1;
%     disp(Yout);
% end
% end
disp("Correct : ");
disp(correct1);
disp("Wrong :");
disp(wrong1);




