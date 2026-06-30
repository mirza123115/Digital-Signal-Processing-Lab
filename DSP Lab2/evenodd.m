function [xe,xo,n] = evenodd(x,n)

% ---------------------------------------------------------
% Even and odd decomposition
% ---------------------------------------------------------

% Check if signal is real
if any(imag(x) ~= 0)
    error('x is not a real sequence');
end

% Folded signal
xf = fliplr(x);

% Even component
xe = 0.5 * (x + xf);

% Odd component
xo = 0.5 * (x - xf);

end