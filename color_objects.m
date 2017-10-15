% Xiaozhe Li
% Homework4
% color_objects
% this function randomly generate base colors
% if you had wrong result, it might due to the two simliar random color
% try multiple runs for a better and more precise result
function [output] = color_objects(input)
new = linspace(0.01,0.99,100);
front =  zeros(20000,2);
image = double(input);
[height,width] = size(image);
output = zeros(height,width,3);
p = 1;
for x = 1:height
    for y = 1:width
        origin_color = image(x,y); 
        if origin_color ==0 || origin_color == 1
            image(x,y) = new(p);
            number = 1;
            front(number,1) = x;
            front(number, 2) =y;
            p = p+1;
            while number ~=0 
                first = front(number,1);
                second = front(number,2);
                number = number-1;
                if min(first-1,second)>0 && first-1 <= height && second <= width && image(first-1,second) == origin_color  
                   image(first-1,second) = image(first,second);
                   number = number +1;
                   front(number,1) = first-1;
                   front(number, 2) = second;
                end
                if second>0 && first+1 <= height && second <= width && image(first+1,second) == origin_color 
                   image(first+1,second) = image(first,second);
                   number = number +1;
                   front(number,1) = first+1;
                   front(number, 2) = second;
                end
                if min (first,second-1)>0 && first<= height &&  second-1 <= width && image(first,second-1) == origin_color   
                   image(first,second-1) = image(first,second);
                   number = number +1;
                   front(number,1) = first;
                   front(number, 2) = second-1;
                end
                if first>0 && first <= height && second+1 <= width && image(first,second+1) == origin_color
                   image(first,second+1) = image(first,second);
                   number = number +1;
                   front(number,1) = first;
                   front(number, 2) = second+1;
                end
            end
        end
    end
end

for i = 1:100
    r(i) = randi([1 255], 1, 1);
    g(i) = randi([1 255], 1, 1);
    b(i) = randi([1 255], 1, 1);
end

for x = 1:height
    for y = 1:width
        for k = 1:100
            if image(x,y) == new(k)
                output(x,y,1) = r(k);
                output(x,y,2) = g(k);
                output(x,y,3) = b(k);
            end
        end
    end
end

output = uint8(output);
imshow(output);
end
           
            
            
            
            
            
            
            
            
            

                