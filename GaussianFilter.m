% Write code to construct the Gaussian, first-derivative, and
% second-derivative kernels, all parameterized by the standard deviation s. Then write code
% to apply these kernels to a grayscale image, computing the smoothed image, the gradient
% components in x and y, the gradient magnitude, and the LoG.

image = 'Desert.jpg';
RGB = imread(image);
I= rgb2gray(RGB);
sigma = 40;
[height, width] = size(I);
output1 = GetKernelHalfWidth(sigma);
output2 = CreateGaussianKernel(sigma);
output3 = CreateGaussianDerivativeKernel(sigma);
output5 = CreateGaussianSecondDerivativeKernel(sigma);
output6 = CreateGaussian2DKernel(sigma);
output7 = SmoothImage(I,sigma)

function output = SmoothImage(I,sigma)
gauss = CreateGaussianKernel(sigma);
I2 = ConvolveSeparable(I,gauss, gauss,sigma);
output = I2;
return
end

function output = GetKernelHalfWidth(sigma)
output = round(2.5*sigma-0.5);
return
end

function output = CreateGaussianKernel(sigma)
w_tide = GetKernelHalfWidth(sigma);
w = 2*w_tide + 1;
norm = 0;
for k = 1: w
    gauss(k) = exp(-(k-w_tide)*(k-w_tide)/(2*sigma*sigma));
    norm = norm +gauss(k);
end
% for k = 1 : w 
%     gauss(k) = gauss(k)/norm;
% end
output = gauss;
return
end

function output = CreateGaussian2DKernel(sigma)
kernel1D = CreateGaussianKernel(sigma);
kernel2D = kernel1D' * kernel1D; 
kernel2D = kernel2D / sum(kernel2D(:));
output = kernel2D;
return
end

function output = CreateGaussianDerivativeKernel(sigma)
w_tide = GetKernelHalfWidth(sigma);
w = 2*w_tide+1;
norm =0;
for i = 1:w
    gauss_deriv(i) = (i-w_tide)*exp(-(i-w_tide)*(i-w_tide)/(w*sigma*sigma));
    norm = norm - i*gauss_deriv(i);
end
for i = 1 : w
    gauss_deriv(i) = gauss_deriv(i) / norm;
end
output = gauss_deriv;
return
end

function output = CreateGaussianSecondDerivativeKernel(sigma)
w_tide = GetKernelHalfWidth(sigma);
w = 2*w_tide+1;
norm =0;
for i = 1:w
    gauss_secondderiv(i) = -(1/sigma*sigma-i*i/sigma^4)*exp(-(i-w_tide-1)*(i-w_tide-1)/(2*sigma*sigma));
end
for i = 1 : w_tide
    norm = norm + i*i*gauss_secondderiv(i);
end
    gauss_secondderiv(i) = gauss_secondderiv(i) / norm;
output = gauss_secondderiv;
return
end

function output = ConvolveSeparable(I,gh,gv,sigma)
[height, width] = size(I);
w_tide = GetKernelHalfWidth(sigma);
w = GetKernelHalfWidth(sigma)*2+1;
for y=1 : width
    for x=w_tide+1 : height-w_tide
        val = 0;   
        for k = 1: w
            val = val + gh(k)*I(x+w_tide-k+1,y); 
        end
         I_tmp(x,y) = val;
    end
end

for x =1 :height - 2
    for y=w_tide+1 : width-w_tide-1
        val2 = 0;
        for k = 1:w
            val2 = val2 + gv(k) * I_tmp(x,y+w_tide-k+1); 
        end
        I2(x,y) = val2;
    end
end
output = I2;
return
end

function [output1,output2] = ComputerImageGradient(I,sigma)
gauss = CreateGaussianKernel(sigma);
gauss_deriv = CreateGaussianDerivativeKernel(sigma);
G_x = ConvolveSeparable(I,gauss_deriv,gauss);
G_y = ConvolveSeparable(I,gauss,gauss_deriv);
[height,width] = size(I);
for x = 1:height
    for y = 1:width
        G_mag = abs(G_x(x,y)) + abs(G_y(x,y));
        G_phase = atan2(G_y(x,y),G_x(x,y));
    end
end
output1 = G_mag;
output2 = G_phase;
return
end


