% Xiaozhe Li
% HW1

function flip = flipim(file)
%verify the path and name of your file below
%------------------------------------
%file = 'Desert.jpg';
%------------------------------------
%I = imread(file);
image(file);


array1 = file(1:(end/2), 1:(end/2),:);
array2 = file(1:end/2, end/2:end-1,:);
array3 = file(end/2+1:end, 1:end/2,:);
array4 = file(end/2+1:end, end/2:end-1,:);
flip = [array4 array3 
        array2 array1];
image(flip)

end