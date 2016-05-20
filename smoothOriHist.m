% 
%   Copyright (C) 2016  Starsky Wong <sununs11@gmail.com>
% 
%   Note: The SIFT algorithm is patented in the United States and cannot be
%   used in commercial products without a license from the University of
%   British Columbia.  For more information, refer to the file LICENSE
%   that accompanied this distribution.

function smoothOriHist(hist,n)
% Function: Smooth orientation histogram
    for i = 1:n
        if (i==1)
            prev = hist(n);
            next = hist(2);
        elseif (i==n)
            prev = hist(n-1);
            next = hist(1);
        else
            prev = hist(i-1);
            next = hist(i+1);
        end
        hist(i) = 0.25*prev + 0.5*hist(i) + 0.25*next;
    end
end

