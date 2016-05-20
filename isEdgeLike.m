% 
%   Copyright (C) 2016  Starsky Wong <sununs11@gmail.com>
% 
%   Note: The SIFT algorithm is patented in the United States and cannot be
%   used in commercial products without a license from the University of
%   British Columbia.  For more information, refer to the file LICENSE
%   that accompanied this distribution.

function [ flag ] = isEdgeLike( img, x, y, curv_thr )
% Function: Remove edge-like points
center = img(x,y);
dxx = img(x,y+1) + img(x,y-1) - 2*center;
dyy = img(x+1,y) + img(x-1,y) - 2*center;
dxy = ( img(x+1,y+1) + img(x-1,y-1) - img(x+1,y-1) - img(x-1,y+1) )/4;
tr = dxx + dyy;
det = dxx * dyy - dxy * dxy;

if ( det <= 0 )
    flag = 1;
    return;
elseif ( tr^2 / det < (curv_thr + 1)^2 / curv_thr )
    flag = 0;
else
    flag = 1;
end
end