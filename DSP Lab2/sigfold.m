function [y,n] = sigfold(x,n)

% ---------------------------------------------------------
% Folding operation
% y(n) = x(-n)
% ---------------------------------------------------------

% Reverse sequence
y = fliplr(x);

% Reverse index
n = -fliplr(n);

end


