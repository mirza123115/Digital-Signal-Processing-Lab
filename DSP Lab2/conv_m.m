function [y,ny] = conv_m(x,nx,h,nh)

% ---------------------------------------------------------
% Modified convolution routine
% ---------------------------------------------------------

% Perform convolution
y = conv(x,h);

% Compute output index range
nyb = nx(1) + nh(1);

nye = nx(length(x)) + nh(length(h));

% Output index vector
ny = nyb:nye;

end



