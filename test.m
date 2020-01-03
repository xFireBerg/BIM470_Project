function [acc, correct, wrong] = test(XTest,YTest,W,filter)
   
    bias = 1;
    correct = 0;
    wrong = 0;
    
    for i = 1:20
        
        image = XTest(:,:,:,i);
        class = YTest(i,1);


        % Forward 
        [Yout,~,~,~,~,~] = forward(W,bias,image,filter);
            if (class == 1)
                if (Yout(1)>Yout(2)) && (Yout(1)>Yout(3))
                    %disp("Class-1 CORRECT")
                    correct = correct+1;

                else
                    %disp("Class-1 WRONG  @@@")
                    wrong = wrong+1;
                end

            end
            if (class == 2)
                if (Yout(2)>Yout(3)) && (Yout(2)>Yout(1))
                    %disp("Class-2 CORRECT")
                    correct = correct+1;

                else
                    %disp("Class-2 WRONG  @@@")
                    wrong = wrong+1;            
                end

            end
            if (class == 3)
                if (Yout(3)>Yout(2)) && (Yout(3)>Yout(1))
                    %disp("Class-3 CORRECT")
                    correct = correct+1;

                else
                    %disp("Class-3 WRONG  @@@")
                    wrong = wrong+1;            

                end
        
            end
    end
    
    
    acc = correct/20;
    
end