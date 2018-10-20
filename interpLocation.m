% 
%   Copyright (C) 2016  Starsky Wong <sununs11@gmail.com>
% 
%   Note: The SIFT algorithm is patented in the United States and cannot be
%   used in commercial products without a license from the University of
%   British Columbia.  For more information, refer to the file LICENSE
%   that accompanied this distribution.

function [ ddata ] = interpLocation( dog_imgs, height, width, octv, intvl, x, y, img_border, contr_thr, max_interp_steps )
% Function: Interpolates a scale-space extremum's location and scale
global init_sigma;
global intvls;
i = 1;
while (i <= max_interp_steps)
    dD = deriv3D(intvl,x,y);
    H = hessian3D(intvl,x,y);
    [U,S,V] = svd(H);
    T=S;
    T(S~=0) = 1./S(S~=0);
    svd_inv_H = V * T' * U';
    x_hat = - svd_inv_H*dD;
    if( abs(x_hat(1)) < 0.5 && abs(x_hat(2)) < 0.5 && abs(x_hat(3)) < 0.5)
        break;
    end
    x = x + round(x_hat(1));
    y = y + round(x_hat(2));
    intvl = intvl + round(x_hat(3));
    if (intvl < 2 || intvl > intvls+1 || x <= img_border || y <= img_border || x > height-img_border || y > width-img_border)
        ddata = [];
        return;
    end
    i = i+1;
end
if (i > max_interp_steps)
    ddata = [];
    return;
end
contr = dog_imgs(x,y,intvl) + 0.5*dD'*x_hat;
if ( abs(contr) < contr_thr/intvls )
    ddata = [];
    return;
end
ddata.x = x;
ddata.y = y;
ddata.octv = octv;
ddata.intvl = intvl;
ddata.x_hat = x_hat;
ddata.scl_octv = init_sigma * power(2,(intvl+x_hat(3)-1)/intvls);

function [ result ] = deriv3D(intvl, x, y)
    dx = (dog_imgs(x+1,y,intvl) - dog_imgs(x-1,y,intvl))/2;
    dy = (dog_imgs(x,y+1,intvl) - dog_imgs(x,y-1,intvl))/2;
    ds = (dog_imgs(x,y,intvl+1) - dog_imgs(x,y,intvl-1))/2;
    result = [dx,dy,ds]';
end

function [ result ] = hessian3D(intvl, x, y)
    center = dog_imgs(x,y,intvl);
    dxx = dog_imgs(x+1,y,intvl) + dog_imgs(x-1,y,intvl) - 2*center;
    dyy = dog_imgs(x,y+1,intvl) + dog_imgs(x,y-1,intvl) - 2*center;
    dss = dog_imgs(x,y,intvl+1) + dog_imgs(x,y,intvl-1) - 2*center;

    dxy = (dog_imgs(x+1,y+1,intvl)+dog_imgs(x-1,y-1,intvl)-dog_imgs(x+1,y-1,intvl)-dog_imgs(x-1,y+1,intvl))/4;
    dxs = (dog_imgs(x+1,y,intvl+1)+dog_imgs(x-1,y,intvl-1)-dog_imgs(x+1,y,intvl-1)-dog_imgs(x-1,y,intvl+1))/4;
    dys = (dog_imgs(x,y+1,intvl+1)+dog_imgs(x,y-1,intvl-1)-dog_imgs(x,y-1,intvl+1)-dog_imgs(x,y+1,intvl-1))/4;

    result = [dxx,dxy,dxs;dxy,dyy,dys;dxs,dys,dss];
end

end


