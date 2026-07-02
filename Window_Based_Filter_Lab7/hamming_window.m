function w = hamming_window(M)

% Hamming Window

n = 0:M-1;

w = 0.54 - 0.46*cos((2*pi*n)/(M-1));

w = w(:);

end