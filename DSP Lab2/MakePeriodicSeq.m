function ny = MakePeriodicSeq(y,N)

% ---------------------------------------------------------
% Generates periodic sequence
% y = one period of sequence
% N = number of repetitions
% ---------------------------------------------------------

% Convert into column vector
y = y(:);

% Repeat sequence N times
ny = y * ones(1,N);

% Convert matrix into row vector
ny = ny(:)';

end