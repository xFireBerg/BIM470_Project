function [acc, correct, wrong] = test(XTest,YTest,W,filter)
   
    % This function is for calculating accuracy 
    % 
    
    % parameters and values for accuracy calculations
    bias = 1;
    correct = 0;
    wrong = 0;
    
    % we have 20 image for test so 1:20
    % Go through all of them and find number of correct-wrong prediction
    for i = 1:20
        
        image = XTest(:,:,:,i);
        class = YTest(i,1);


        % Forward and get output
        % Yout is the result of forwad operations 
        [Yout,~,~,~,~,~] = forward(W,bias,image,filter);
        
            if (class == 1)
                % For class 1  Yout(1) should be the max 
                if (Yout(1)>Yout(2)) && (Yout(1)>Yout(3))
                    correct = correct+1;

                else   
                    wrong = wrong+1;
                end

            end
            if (class == 2)
                % For class 2  Yout(2) should be the max 
                if (Yout(2)>Yout(3)) && (Yout(2)>Yout(1))     
                    correct = correct+1;

                else      
                    wrong = wrong+1;            
                end

            end
            if (class == 3)
                % For class 3  Yout(3) should be the max 
                if (Yout(3)>Yout(2)) && (Yout(3)>Yout(1))
                    correct = correct+1;

                else
                    wrong = wrong+1;            

                end
        
            end
    end
    
    % acc = correct/total
    % we calculate accuracy with this formula 
    acc = correct/20;
    
end