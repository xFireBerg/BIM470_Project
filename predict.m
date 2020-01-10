function predicted = predict(Test,W,filter)


    bias = 1;
    [~,~,L] = size(Test);
    class = 0;

    
    % we have 20 image for test so 1:20
    % Go through all of them and find number of correct-wrong prediction
    for i = 1:L
        
        image = Test(:,:,i);

        % Forward and get output
        % Yout is the result of forwad operations 
        [Yout,~,~,~,~,~] = forward(W,bias,image,filter);
        [Max,I] = max(Yout);
        if I == 1
            class = 1;
        end
        if I == 2
            class = 2; 
        end
        if I == 3
            class = 3;
        end
        X = ['Predict --> Class - ',num2str(class),'       -     Class 1: ',num2str(Yout(1)),'  Class 2: ',num2str(Yout(2)),'  Class 3: ',num2str(Yout(3))];
        disp(X);
        
        predicted = Yout;

    
    end



end