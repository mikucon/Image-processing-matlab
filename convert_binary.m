% Xiaozhe Li
% Homework 4
% convert to binary img

input= imread ('tools.pgm'); 

struct_element = ones(3);
mask = imopen(input,struct_element);
result = imerode(mask,struct_element);
[height,width] = size(result);
for x = 1:height
    for y = 1:width
        if result(x,y) <= 150
            result(x,y) = 0;
        else
            result(x,y) = 255;
        end
    end
end
imshow(input);
title('Original image');
figure, 
imshow(result);
title('Binary image');
