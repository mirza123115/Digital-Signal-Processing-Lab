%% ===== Helper Function: fftseq.m (used in Example 7) =====
function [M,m,df1] = fftseq(m,ts,df)
fs = 1/ts;
n1 = fs/df;
n2 = length(m);
n = 2^(max(nextpow2(n1),nextpow2(n2)));
M = fft(m,n);
m = [m,zeros(1,n-n2)];
df1 = fs/n;
end
