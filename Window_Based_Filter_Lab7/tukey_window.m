function w = tukey_window(M,alpha)

% Tukey Window

n = 0:M-1;

w = zeros(1,M);

for k = 1:M

    if n(k) <= alpha*(M-1)/2

        w(k) = 0.5*(1+cos(pi*((2*n(k))/(alpha*(M-1))-1)));

    elseif n(k) <= (M-1)*(1-alpha/2)

        w(k) = 1;

    else

        w(k) = 0.5*(1+cos(pi*((2*n(k))/(alpha*(M-1))-2/alpha+1)));

    end

end

w = w(:);

end