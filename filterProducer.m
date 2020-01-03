function r = filterProducer(size,number)
        A = zeros(size,size,number);
        rng(1);
        for i = 1:number
            A(:,:,i)= randi([-100 100],size)/1000;
        end
%         A(:,:,1)= [1 0 ; 0 1];
%         A(:,:,2)= [0 1 ; 1 0];
%         A(:,:,3)= [0 0 ; 1 1];
%         A(:,:,4)= [1 1 ; 0 0];
%         A(:,:,5)= [1 1 ; 0 1];
        r = A;
end