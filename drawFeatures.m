% 
%   Copyright (C) 2016  Starsky Wong <sununs11@gmail.com>
% 
%   Note: The SIFT algorithm is patented in the United States and cannot be
%   used in commercial products without a license from the University of
%   British Columbia.  For more information, refer to the file LICENSE
%   that accompanied this distribution.

function [] = drawFeatures( img, loc )
% Function: Draw sift feature points
figure;
imshow(img);
hold on;
plot(loc(:,2),loc(:,1),'+g');
end