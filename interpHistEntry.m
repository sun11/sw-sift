% 
%   Copyright (C) 2016  Starsky Wong <sununs11@gmail.com>
% 
%   Note: The SIFT algorithm is patented in the United States and cannot be
%   used in commercial products without a license from the University of
%   British Columbia.  For more information, refer to the file LICENSE
%   that accompanied this distribution.

function [hist] = interpHistEntry(hist,r,c,o,m,d,obins)
% Function: Interplation for hist entry
r0 = floor(r);
c0 = floor(c);
o0 = floor(o);
d_r = r - r0;
d_c = c - c0;
d_o = o - o0;

for i = 0:1
    r_index = r0 + i;
    if (r_index >= 0 && r_index < d)
        for j = 0:1
            c_index = c0 + j;
            if (c_index >=0 && c_index < d)
                for k = 0:1
                    o_index = mod(o0+k,obins);
                    % if i == 0, m*(1-d_r)*...
                    % if i == 1, m*d_r*...
                    value = m * ( 0.5 + (d_r - 0.5)*(2*i-1) ) ...
                        * ( 0.5 + (d_c - 0.5)*(2*j-1) ) ...
                        * ( 0.5 + (d_o - 0.5)*(2*k-1) );
                    hist_index = r_index*d*obins + c_index*obins + o_index +1;
                    hist(hist_index) = hist(hist_index) + value;
                end
            end
        end
    end
end

end

