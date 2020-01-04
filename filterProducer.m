function r = filterProducer(size,number)

        % Produce random filters
        
        A = zeros(size,size,number);
        rng(1);
        for i = 1:number
            A(:,:,i)= randi([-1000 1000],size)/10000;
        end
        r = A;
end