function r = filterProducer(size,number)
        A = zeros(size,size,number);
        for i = 1:number
            A(:,:,i)= randi([-100 100],size)/100;
        end
        r = A;
end