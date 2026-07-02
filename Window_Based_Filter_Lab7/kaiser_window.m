function w = kaiser_window(M,beta)

% Kaiser Window

n = 0:M-1;

alpha = (M-1)/2;

w = zeros(1,M);

for k = 1:M

    t = (n(k)-alpha)/alpha;

    w(k) = besseli(0,beta*sqrt(1-t^2))/besseli(0,beta);

end

w = w(:);

end