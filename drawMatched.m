% 
%   Copyright (C) 2016  Starsky Wong <sununs11@gmail.com>
% 
%   Note: The SIFT algorithm is patented in the United States and cannot be
%   used in commercial products without a license from the University of
%   British Columbia.  For more information, refer to the file LICENSE
%   that accompanied this distribution.

function [] = drawMatched( matched, img1, img2, loc1, loc2 )
% Function: Draw matched points
% Create a new image showing the two images side by side.
img3 = appendimages(img1,img2);

% Show a figure with lines joining the accepted matches.
figure('Position', [100 100 size(img3,2) size(img3,1)]);
colormap gray;
imagesc(img3);
hold on;
cols1 = size(img1,2);
n = size(matched,2);
colors = ['c','m','y'];
colors_n = length(colors);
for i = 1: n
  if (matched(i) > 0)
    color = colors(randi(colors_n));
    line([loc1(i,2) loc2(matched(i),2)+cols1], ...
         [loc1(i,1) loc2(matched(i),1)], 'Color', color);
  end
end
hold off;
num = sum(matched > 0);
fprintf('Found %d matches.\n', num);

end

function im = appendimages(image1, image2)
% im = appendimages(image1, image2)
%
% Return a new image that appends the two images side-by-side.

% Select the image with the fewest rows and fill in enough empty rows
%   to make it the same height as the other image.
rows1 = size(image1,1);
rows2 = size(image2,1);

if (rows1 < rows2)
     image1(rows2,1) = 0;
else
     image2(rows1,1) = 0;
end

% Now append both images side-by-side.
im = [image1 image2];
end

