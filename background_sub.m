%Xiaozhe Li
%HW3
% background_sub
% a script file to automatically generate the average image among given frames
% it also generates thresholded result with randomly generated frame numbers and thresholded value
% 
% Algorithm: O(n)
% 
% read the total video and store it in the matrix as images
% create loops for each image
% read the image and calculate grayscale for every image in the matrix
% calculate the total average image
% by randomly creted values for start frame and thresholded
% create matrices that satisfy the threshold condition

movie =  VideoReader('FroggerHighway.avi');

height = movie.Height;
width = movie.Width;
mov = struct('h',zeros(height,width,3,'uint8'));

for i = 1:100

    mov(i).h = readFrame(movie);

end

for i=1:100
    
    color = mov(i).h;
    
    grayImg{i} = color(:,:,1)/4 + color(:,:,2)/2 + color(:,:,3)/4;
    
end

sum{1} = uint16(grayImg{1});

for i = 2:100
    
    sum{i} = sum{i-1} + uint16(grayImg{i});
    
end

avgImg = uint8(sum{100}/100);

imshow(avgImg, [])

num = randi([1 90], 1, 1);

threshold = randi([1 90],1,1);

for i = num:num+9
    
        thresholdImg{i} = (abs(grayImg{i} - avgImg)> threshold);
        figure,
        imshow(thresholdImg{i})
        threshold = threshold +1;
end

