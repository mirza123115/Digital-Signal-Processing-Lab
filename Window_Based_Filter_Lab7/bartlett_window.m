function w = bartlett_window(M)

% Bartlett (Triangular) Window

n = 0:M-1;

w = 1 - (2*abs(n-(M-1)/2))/(M-1);

w = w(:);

end