clear all
close all
clc

%% ===== Example 1: Bandpass FIR Filter Design using Kaiser Window =====

FS = 1000;              % Sampling frequency
FN = FS/2;               % Nyquist frequency
N = 73;                  % Filter length
beta = 5.65;             % Kaiser window ripple parameter
fc1 = 125/FN;             % Normalized cutoff frequencies
fc2 = 275/FN;
FC = [fc1 fc2];           % Band edge frequency vector

hn = fir1(N-1, FC, kaiser(N, beta));   % Windowed filter coefficients
[H, f] = freqz(hn, 1, 512, FS);
mag = 20*log10(abs(H));

plot(f, mag), grid on
xlabel('Frequency (Hz)')
ylabel('Magnitude Response (dB)')


%% ===== Example 2: IIR Lowpass Filter Design using Bilinear Transform =====

% ---- Step 1: Analog prototype (normalized cutoff) ----
[z,p,k] = buttap(6);
[b,a] = zp2tf(z,p,k);

% ---- Step 2: Convert to actual cutoff frequency ----
wc = 1.5;
[b1,a1] = lp2lp(b,a,wc);

% ---- Step 3: Map analog to digital using bilinear transform ----
T = 0.5;
[Nz,Dz] = bilinear(b1,a1,1/T);
w = 0:2*pi/300:pi;
Gz = freqz(Nz,Dz,w);

clf;
plot(w,abs(Gz)); axis([0 2 0 1]); grid; hold on;
xlabel('Radian Frequency w in rads/sec'),
ylabel('Magnitude of G(z)'),
title('Digital Filter Response in Normalized Frequency');

fprintf('Press any key to continue \n');
pause;

% ---- Step 4: Digital filter design with prewarping (using butter) ----
p = 6; T = 0.5;
wc = 1.5;
wd = wc*T/pi;
[Nzp,Dzp] = butter(p,wd);

fprintf('Summary: \n\n');
fprintf('WITHOUT PREWARPING: \n\n');
fprintf('The num N(z) coefficients in descending order of z are: \n\n');
fprintf('%8.4f \t',[Nz]);
fprintf('\n\n');
fprintf('The den D(z) coefficients in descending order of z are: \n\n');
fprintf('%8.4f \t',[Dz]);
fprintf('\n\n');
fprintf('WITH PREWARPING: \n\n');
fprintf('The num N(z) coefficients in descending order of z are: \n\n');
fprintf('%8.4f \t',[Nzp]);
fprintf('\n\n');
fprintf('The den D(z) coefficients in descending order of z are: \n\n');
fprintf('%8.4f \t',[Dzp]);
fprintf('\n\n');

% ---- Step 5: Apply filter to remove higher-order cosine terms ----
n = 0:150;
T = 0.5;
gt = 3+1.5*sin(n*T)-cos(2*n*T);
yt = filter(Nzp,Dzp,gt);

t = 0:0.1:12;
gta = 3+1.5*sin(t)-cos(2*t);

subplot(211), plot(t,gta), axis([0,12, 0, 6]); hold on;
xlabel('Continuous Time t'); ylabel('Function g(t)');

subplot(212), plot(n*T,yt), axis([0,12, 0, 6]); hold on;
xlabel('Continuous Time t'); ylabel('Filtered Output y(t)');

fprintf('Press any key to continue \n'); pause;

subplot(211), stem(n*T,gt), axis([0,12, 0, 6]); hold on;
xlabel('Discrete Time nT'); ylabel('Discrete Function g(n*T)');

subplot(212), stem(n*T,yt), axis([0,12, 0, 6]); hold on;
xlabel('Discrete Time nT'); ylabel('Filtered Output y(n*T)')


%% ===== Example 7: Cascade-to-Parallel Structure Conversion =====

nstage = 2;
N1 = [1 0.481199 1];
N2 = [1 1.474597 1];
D1 = [1 0.052921 0.831731];
D2 = [1 -0.304609 0.238865];
sos = [N1 D1; N2 D2];
[b, a] = sos2tf(sos);
[c, p, k] = residuez(b, a);
m = length(b);
b0 = b(m)/a(m);

j = 1;
for i = 1:nstage
    bk(j) = c(j)+c(j+1);
    bk(j+1) = -(c(j)*p(j+1)+c(j+1)*p(j));
    ak(j) = -(p(j)+p(j+1));
    ak(j+1) = p(j)*p(1+j);
    j = j+2;
end

b0
ak
bk
c
p
k



%% ============================================================
% LAB-7
% Problem-1
% Chebyshev Type-I High Pass Analog Filter
% ============================================================

clear
clc
close all

% Filter Specifications

N = 3;
Rp = 1;
fc = 5000;
wc = 2*pi*fc;

% Normalized Chebyshev Type-I Prototype

[z,p,k] = cheb1ap(N,Rp);

% Convert Zero-Pole-Gain to Transfer Function

[b,a] = zp2tf(z,p,k);

% Convert Low Pass to High Pass

[bh,ah] = lp2hp(b,a,wc);

% Display Transfer Function

disp('Numerator Coefficients')
disp(bh)

disp('Denominator Coefficients')
disp(ah)

% Frequency Response

w = logspace(3,6,1000);

H = freqs(bh,ah,w);

figure

subplot(2,1,1)
semilogx(w/(2*pi),20*log10(abs(H)),'LineWidth',2)
grid on
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
title('Magnitude Response')

subplot(2,1,2)
semilogx(w/(2*pi),unwrap(angle(H))*180/pi,'LineWidth',2)
grid on
xlabel('Frequency (Hz)')
ylabel('Phase (Degree)')
title('Phase Response')

% Pole Zero Plot

figure
zplane(bh,ah)
grid on
title('Pole Zero Plot')

% Transfer Function

Hs = tf(bh,ah)


%% ============================================================
% LAB-7
% Problem-2
% Design of Butterworth Digital Low Pass Filter
% Using Bilinear Transformation
% ============================================================

clear
clc
close all

% Filter Specifications

N = 2;              % Filter Order
fc = 50;            % Cutoff Frequency (Hz)
Fs = 500;           % Sampling Frequency (Hz)

% Analog Cutoff Frequency (rad/sec)

Wc = 2*pi*fc;

% Design Analog Butterworth Low Pass Filter

[b,a] = butter(N,Wc,'s');

% Convert Analog Filter to Digital Filter

[num,den] = bilinear(b,a,Fs);

% Display Transfer Function

disp('Digital Numerator Coefficients')
disp(num)

disp('Digital Denominator Coefficients')
disp(den)

Hz = tf(num,den,1/Fs)

% Frequency Response

figure

freqz(num,den,1024,Fs)

title('Magnitude and Phase Response')

% Pole-Zero Plot

figure

zplane(num,den)

grid on

title('Pole-Zero Plot')



% ============================================================
% LAB-7
% Problem-3
% Butterworth Lowpass Digital Filter
% Impulse Invariant Method vs Bilinear Transform Method
% ============================================================

clear
clc
close all

% Filter Specifications

N = 5;              % Filter Order
fc = 300;           % Cutoff Frequency (Hz)
Fs = 1000;          % Sampling Frequency (Hz)

% Analog Cutoff Frequency

Wc = 2*pi*fc;

% Design Analog Butterworth Lowpass Filter

[b,a] = butter(N,Wc,'s');

% ------------------------------------------------------------
% Impulse Invariant Method
% ------------------------------------------------------------

[bii,ai] = impinvar(b,a,Fs);

% ------------------------------------------------------------
% Bilinear Transform Method
% ------------------------------------------------------------

[bbl,abl] = bilinear(b,a,Fs);

% ------------------------------------------------------------
% Magnitude Responses
% ------------------------------------------------------------

figure

freqz(bii,ai,1024,Fs)
title('Impulse Invariant Method')

figure

freqz(bbl,abl,1024,Fs)
title('Bilinear Transform Method')

% ------------------------------------------------------------
% Group Delay
% ------------------------------------------------------------

figure

grpdelay(bii,ai,1024,Fs)
title('Group Delay (Impulse Invariant)')

figure

grpdelay(bbl,abl,1024,Fs)
title('Group Delay (Bilinear Transform)')

% ------------------------------------------------------------
% Magnitude Comparison
% ------------------------------------------------------------

[H1,f] = freqz(bii,ai,1024,Fs);
[H2,~] = freqz(bbl,abl,1024,Fs);

figure

plot(f,20*log10(abs(H1)),'LineWidth',2)
hold on
plot(f,20*log10(abs(H2)),'LineWidth',2)

grid on

xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
title('Magnitude Response Comparison')

legend('Impulse Invariant','Bilinear')

% ------------------------------------------------------------
% Group Delay Comparison
% ------------------------------------------------------------

[gd1,w1] = grpdelay(bii,ai,1024,Fs);
[gd2,w2] = grpdelay(bbl,abl,1024,Fs);

figure

plot(w1,gd1,'LineWidth',2)
hold on
plot(w2,gd2,'LineWidth',2)

grid on

xlabel('Frequency (Hz)')
ylabel('Group Delay (Samples)')
title('Group Delay Comparison')

legend('Impulse Invariant','Bilinear')

% ------------------------------------------------------------
% Transfer Functions
% ------------------------------------------------------------

disp('Impulse Invariant Filter')
tf(bii,ai,1/Fs)

disp('Bilinear Transform Filter')
tf(bbl,abl,1/Fs)


% ============================================================
% LAB-7
% Problem-5
% Butterworth Lowpass Digital Filter
% Impulse Invariant Method vs Bilinear Transform Method
% ============================================================



clear all;
echo on;

Fs = 1000;
Fn = Fs/2;              % Nyquist frequency = 500 Hz

% Normalized band-edge frequencies
Wp = [200 300]/Fn;      % Passband edges
Ws = [50 450]/Fn;       % Stopband edges
Rp = 3;                 % Passband ripple (dB)
Rs = 20;                % Stopband attenuation (dB)

% (1)(i) Determine minimum filter order N and cutoff frequencies Wn
[N, Wn] = buttord(Wp, Ws, Rp, Rs);
fprintf('Required filter order N = %d\n', N);
fprintf('Cutoff frequencies Wn = '); disp(Wn);

% (1)(ii) Design the digital Butterworth bandpass filter (BZT method)
[b,a] = butter(N, Wn);
[z,p,k] = tf2zp(b,a);

fprintf('Zeros:\n'); disp(z);
fprintf('Poles:\n'); disp(p);
fprintf('Gain k = %f\n', k);
fprintf('Numerator coefficients b(z):\n'); disp(b);
fprintf('Denominator coefficients a(z):\n'); disp(a);

% (2) Plot magnitude-frequency response
figure;
[H,f] = freqz(b,a,1024,Fs);
plot(f, 20*log10(abs(H))); grid on;
xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)');
title('Bandpass Butterworth Filter — Magnitude Response');

% Plot pole-zero diagram
figure;
zplane(z,p);
title('Pole-Zero Diagram of Bandpass Butterworth Filter');