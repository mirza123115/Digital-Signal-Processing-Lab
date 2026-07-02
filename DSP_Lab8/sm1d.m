function y = sm1d(x, window, choice)
%SM1D Smooth a 1d signal. You can have the choice of mean
% or median smoothing, and also you can control the smoothing 
% window size.USAGE sm1d(x, h, choice), where
% x = the signal data
% window = window width, eg 3 means span 3 smoothing.
% choice = 'mean' if mean smoothing
% = 'median' if median smoothing
n = length(x);
h = floor((window - 1)/2);
y = x;

if strcmp(choice, 'mean')
    for i = 1:n
        bg = max(1, i-h);
        ed = min(n, i+h);
        y(i) = mean(x(bg:ed));
    end
elseif strcmp(choice, 'median')
    for i = 1:n
        bg = max(1, i-h);
        ed = min(n, i+h);
        y(i) = median(x(bg:ed));
    end
else
    error('Wrong smoothing method');
end