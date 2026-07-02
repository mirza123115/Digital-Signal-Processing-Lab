function w = hanning_window(M)

% Hanning Window

n = 0:M-1;

w = 0.5*(1-cos((2*pi*n)/(M-1)));

w = w(:);

end