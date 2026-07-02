clear all;
echo on;
x = linspace(1, 10, 100);
f = 5 + x.*sin(x); %signal
y = f + randn(1, 100).*2; %Gaussian noise N(0, 22) added
subplot(321)
plot(x, f);
title('Original signal')
subplot(322)
plot(x, y);
title('Noisy signal')
rf1 = conv(y, [0.25, 0.5, 0.25]); %3-point weighted average
size(rf1) %note length of rf is NOT 100
rf1 = rf1(2:101); %middle 100 points give the solution
subplot(323)
plot(x, rf1);
title('Filtered with 3-point weighted average')
rf2 = conv(y, ones(1, 3)/3);
subplot(324)
plot(x, rf2(2:101));
title('Filtered with 3-point moving average')
rf3 = conv(y, ones(1, 7)/7);
subplot(3,2,[5:6])
plot(x, rf3(4:103)); %note the length of rf3
title('Filtered with 7-point moving average')


%%%%%%%%%Example 2:Moving Average using filter.m%%%%%%%%%%%%%
clear all;
t=0:.01:1;
f=5;
y=sin(2*pi*f*t);
%Generation of random signal
g=0.5*randn(size(t));
z=g+y;
N=10; %order required
b=1/N*(ones(1,N));
x=filter(b,1,z); %filters noice
subplot(3,1,1);
plot(t,y);
ylabel('pure signal');
subplot(3,1,2);
plot(t,z);
ylabel('noise buried');
subplot(3,1,3);
plot(t,x);
ylabel('filtered signal');
xlabel('Time in seconds');



%% Example 3: Median Filter
clear all;
echo on;
x = linspace(1, 10, 100);
f = 5 + x.*sin(x); %signal
y = f + randn(1, 100).*2; %Gaussian noise N(0, 22) added
subplot(311)
plot(x, f);
title('Original signal')
subplot(312)
plot(x, y);
title('Noisy signal')
mf = sm1d(y, 5, 'median'); %5-point median
subplot(313)
plot(x, mf);
title('filtered signal');



%%%%%%%%%%%%%%%Comb Filters%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
L = 16;
r = 0.995
[b,a] = COMB(r,L);
[z,p,k] = tf2zp(1,b); % IIR comb
subplot(311)
zplane(z,p)

% FIR Comb
[h,w] = freqz(1,b);
subplot(312)
plot(w/pi,abs(h));
xlabel ('Normalized frequency (Nyquist==1)')
ylabel ('Magnitude Response')
title('IIR Comb')

% IIR comb
[h,w] = freqz(b,1);
subplot(313)
plot(w/pi,abs(h));
ylabel 'Magnitude Response'
xlabel 'Normalized frequency (Nyquist==1)'
title('FIR Comb')


%% Moving Average and CIC Filter
clear all;
N = 10;
xn = sin(2*pi*[0:.1:10]);
hn = ones(1,N);
y1n = conv(xn,hn);
% transfer function of Moving Average filter
hF = fft(hn,1024);
plot([-512:511]/1024, abs(fftshift(hF)));
xlabel('Normalized frequency')
ylabel('Amplitude')
title('Frequency response of Moving average filter')