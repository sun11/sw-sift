% 
%   Copyright (C) 2016  Starsky Wong <sununs11@gmail.com>
% 
%   Note: The SIFT algorithm is patented in the United States and cannot be
%   used in commercial products without a license from the University of
%   British Columbia.  For more information, refer to the file LICENSE
%   that accompanied this distribution.

function [mag_ori] = calcGrad(img,x,y)
% Function: Calculate gradients for image pixels
[height,width] = size(img);
mag_ori = [0 0];
if (x > 1 && x < height && y > 1 && y < width)
    % x is vertical, from up to down
    dx = img(x-1,y) - img(x+1,y);
    dy = img(x,y+1) - img(x,y-1);
    mag_ori(1) = sqrt(dx*dx + dy*dy);
    mag_ori(2) = atan2(dx,dy);
else
    mag_ori = -1;
end
end