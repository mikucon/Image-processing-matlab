%HW2
%Xiaozhe Li
%myquantize
function result = myquantize(input, quant_num)

input = double(input);
[height,width] = size(input);
%input = reshape(input, height*width, 1);
result = zeros(height,width);
    k = round(256/quant_num);
    
for i = 1:height
    for j = 1:width
        result(i,j) = floor(input(i,j)/k)*k;
    end
end
imshow(uint8(result))
        
    

