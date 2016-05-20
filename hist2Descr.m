% 
%   Copyright (C) 2016  Starsky Wong <sununs11@gmail.com>
% 
%   Note: The SIFT algorithm is patented in the United States and cannot be
%   used in commercial products without a license from the University of
%   British Columbia.  For more information, refer to the file LICENSE
%   that accompanied this distribution.

function [feat] = hist2Descr(feat,descr,descr_mag_thr)
% Function: Convert histogram to descriptor
descr = descr/norm(descr);
descr = min(descr_mag_thr,descr);
descr = descr/norm(descr);
feat.descr = descr;
end