function [y,n] = sigmult(x1,n1,x2,n2)

% ---------------------------------------------------------
% Performs multiplication of two sequences
% y(n) = x1(n) .* x2(n)
% ---------------------------------------------------------

% Determine common time range
n = min(min(n1),min(n2)) : max(max(n1),max(n2));

% Initialize sequences
y1 = zeros(1,length(n));
y2 = zeros(1,length(n));

% Insert x1 values
y1(find((n >= min(n1)) & (n <= max(n1)))) = x1;

% Insert x2 values
y2(find((n >= min(n2)) & (n <= max(n2)))) = x2;

% Multiply sequences
y = y1 .* y2;

end