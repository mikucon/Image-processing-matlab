%Xiaozhe Li
%HW3
%videosubsamp
%A function to calculates both input frames and output frames and present
%the results
%the output contains 2 frames values

%Algorithms: O(n)

% Read the video
% create zero matrices to store all pictures read from the video
% each image file contains 3 values, height, width and intensity
% All images are stored in a 1*100 cell
% 
% Then calculate the total frames 
% sampling the video by adding images together into new matrix and show the result

function [frame1, frame2] = videosubsamp(input, output, samp_rate)

movie = VideoReader(input);
height = movie.Height;
width = movie.Width;
%create new matrix to store imgs
mov = struct('h',zeros(height,width,3,'uint8'));

i = 1;
while hasFrame(movie)
    mov(i).h = readFrame(movie);
    i = i+1;
end

frame1 = i-1;
result = VideoWriter(output);
open(result);
count = 0;

for k = 1 : samp_rate : frame1
    f = mov(k).h;
    imshow(f);
    writeVideo(result,f);
    count = count +1;
end

frame2 = count;

return;
end
