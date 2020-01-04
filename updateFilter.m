function [updatedFilter] = updateFilter(inputImage,convBack,filter,lr)

%Rotate 180 degree the colvolved image
convBack = rot90(convBack,2);%Rotate 180 degree

%Convolve with input image again
[convolved] = cnv(inputImage,convBack);

% f(n+1) = f + n*deltaFilt
updatedFilter = filter + (lr*convolved);



end