clear all
close all
clc

%% ===== Example 1: Amplitude Response of Type-1 Linear Phase FIR Filter =====
h = [-4,1,-1,-2,5,6,5,-2,-1,1,-4];
M = length(h); n = 0:M-1;
[Hr,w,a,L] = Hr_Type1(h);

a,L
amax = max(a)+1; amin = min(a)-1;

subplot(2,2,1); stem(n,h); axis([-1 2*L+1 amin amax])
xlabel('n'); ylabel('h(n)'); title('Impulse Response')

subplot(2,2,3); stem(0:L,a); axis([-1 2*L+1 amin amax])
xlabel('n'); ylabel('a(n)'); title('a(n) coefficients')

subplot(2,2,2); plot(w/pi,Hr); grid
xlabel('frequency in pi units'); ylabel('Hr')
title('Type-1 Amplitude Response')

subplot(2,2,4); zplane(h,1); title('Pole-Zero Plot')


%% ===== Example 2: Amplitude Response of Type-2 Linear Phase FIR Filter =====
h = [-4,1,-1,-2,5,6,6,5,-2,-1,1,-4];
M = length(h); n = 0:M-1;
[Hr,w,b,L] = Hr_Type2(h);

b,L
bmax = max(b)+1; bmin = min(b)-1;

subplot(2,2,1); stem(n,h); axis([-1 2*L+1 bmin bmax])
xlabel('n'); ylabel('h(n)'); title('Impulse Response')

subplot(2,2,3); stem(1:L,b); axis([-1 2*L+1 bmin bmax])
xlabel('n'); ylabel('b(n)'); title('b(n) coefficients')

subplot(2,2,2); plot(w/pi,Hr); grid
xlabel('frequency in pi units'); ylabel('Hr')
title('Type-2 Amplitude Response')

subplot(2,2,4); zplane(h,1); title('Pole-Zero Plot')


%% ===== Example 3: Amplitude Response of Type-3 Linear Phase FIR Filter =====
h = [-4,1,-1,-2,5,0,-5,2,1,-1,4];
M = length(h); n = 0:M-1;
[Hr,w,c,L] = Hr_Type3(h);

c,L
cmax = max(c)+1; cmin = min(c)-1;

subplot(2,2,1); stem(n,h); axis([-1 2*L+1 cmin cmax])
xlabel('n'); ylabel('h(n)'); title('Impulse Response')

subplot(2,2,3); stem(0:L,c); axis([-1 2*L+1 cmin cmax])
xlabel('n'); ylabel('c(n)'); title('c(n) coefficients')

subplot(2,2,2); plot(w/pi,Hr); grid
xlabel('frequency in pi units'); ylabel('Hr')
title('Type-3 Amplitude Response')

subplot(2,2,4); zplane(h,1); title('Pole-Zero Plot')


%% ===== Example 4 (Corrected): Amplitude Response of Type-4 Linear Phase FIR Filter =====
h = [-4,1,-1,-2,5,6,-6,-5,2,1,-1,4];
M = length(h); n = 0:M-1;
[Hr,w,d,L] = Hr_Type4(h);

d,L                         
dmax = max(d)+1; dmin = min(d)-1;

subplot(2,2,1); stem(n,h); axis([-1 2*L+1 dmin dmax])
xlabel('n'); ylabel('h(n)'); title('Impulse Response')

subplot(2,2,3); stem(1:L,d); axis([-1 2*L+1 dmin dmax])
xlabel('n'); ylabel('d(n)'); title('d(n) coefficients')

subplot(2,2,2); plot(w/pi,Hr); grid
xlabel('frequency in pi units'); ylabel('Hr')
title('Type-4 Amplitude Response')

subplot(2,2,4); zplane(h,1); title('Pole-Zero Plot')