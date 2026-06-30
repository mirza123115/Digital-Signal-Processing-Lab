function [y,n] = sigadd(x1,n1,x2,n2)

% ---------------------------------------------------------
% Performs addition of two sequences
% y(n) = x1(n) + x2(n)
% ---------------------------------------------------------

% Determine common time range
n = min(min(n1),min(n2)) : max(max(n1),max(n2));

% Initialize sequences with zeros
y1 = zeros(1,length(n));
y2 = zeros(1,length(n));

% Insert x1 into proper location
y1(find((n >= min(n1)) & (n <= max(n1)))) = x1;

% Insert x2 into proper location
y2(find((n >= min(n2)) & (n <= max(n2)))) = x2;

% Add sequences
y = y1 + y2;

end