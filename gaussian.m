% 
%   Copyright (C) 2016  Starsky Wong <sununs11@gmail.com>
% 
%   Note: The SIFT algorithm is patented in the United States and cannot be
%   used in commercial products without a license from the University of
%   British Columbia.  For more information, refer to the file LICENSE
%   that accompanied this distribution.

function [ out_img ] = gaussian( input_img, sigma )
% Function: Gaussian smooth for an image
k = 3;
hsize = round(2*k*sigma+1);
if mod(hsize,2) == 0
    hsize = hsize+1;
end
g = fspecial('gaussian',hsize,sigma);
out_img = conv2(input_img,g,'same');
end
