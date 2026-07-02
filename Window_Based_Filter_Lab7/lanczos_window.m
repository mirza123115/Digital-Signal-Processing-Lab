function w = lanczos_window(M,L)

% Lanczos Window

n = 0:M-1;

alpha = (M-1)/2;

w = zeros(1,M);

for k = 1:M

    x = 2*(n(k)-alpha)/(M-1);

    if abs(x) < 1e-12

        w(k) = 1;

    else

        w(k) = (sin(pi*x)/(pi*x))^L;

    end

end

w = w(:);

end