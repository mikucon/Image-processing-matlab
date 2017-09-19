%Xiaozhe Li
%HW2
%Calculate histogram and plot
%function 1 is main function
%function 2 calculates input with scale factor and varies of nbins
%function 3 calculates output with scale factor and varies of nbins

function [Result, output] = myhist(I)
%selected nbins
%used 255 as default
nbins = 255;
%%
I = double(I);
[height,width] = size(I);
input = reshape(I, height*width, 1);
Result = zeros(1, nbins);
max_in = 255; 
min_in = 0; 
max_out = nbins;
min_out = 0; 


input = val2idx(input(:), max_in, min_in,max_out, min_out);

for i = 1 : length(Result)
    Result(i) = sum(input == i);
end

idx = 1 : nbins;

output = idx2val(idx, max_in, min_in, max_out, min_out);

bar(output,Result(:))
title('Graylevel Histogram')
ylabel('Nums of pixels of each level')
xlabel('intensity of light')
end
%%
function idx = val2idx(val, max_in, min_in, max_out, min_out)

Scale_factor = (max_out - min_out) / (max_in - min_in) ;

idx =round(val*Scale_factor) + min_out ;
end
%%
function val = idx2val(idx, max_in, min_in, max_out, min_out)

Scale_factor = (max_out - min_out) ./ (max_in - min_in) ;

val = (idx - min_out)./Scale_factor ;
end
