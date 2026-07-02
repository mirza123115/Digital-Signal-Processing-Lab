%% ===== Helper Function: Hr_Type4.m (Type-4 Linear Phase FIR: Even N, Antisymmetric) =====
function [Hr,w,d,L] = Hr_Type4(h)
M = length(h);
L = M/2;
d = 2*[h(L:-1:1)];
n = [1:1:L]; n = n-0.5;
w = [0:1:500]'*pi/500;
Hr = sin(w*n)*d';
end