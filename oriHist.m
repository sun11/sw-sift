% 
%   Copyright (C) 2016  Starsky Wong <sununs11@gmail.com>
% 
%   Note: The SIFT algorithm is patented in the United States and cannot be
%   used in commercial products without a license from the University of
%   British Columbia.  For more information, refer to the file LICENSE
%   that accompanied this distribution.

function [ hist ] = oriHist( img, x, y, n, rad, sigma )
% Function: Calculate orientation histogram
hist = zeros(n,1);
exp_factor = 2*sigma*sigma;
for i = -rad:rad
    for j = -rad:rad
        [mag_ori] = calcGrad(img,x+i,y+j);
        if(mag_ori(1) ~= -1)
            w = exp( -(i*i+j*j)/exp_factor );
            bin = 1 + round( n*(mag_ori(2) + pi)/(2*pi) );
            if(bin == n +1)
                bin = 1;
            end
            hist(bin) = hist(bin) + w*mag_ori(1);
        end
    end
end
end