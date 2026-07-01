clear all
close all
clc
%% Continuous-Time Cosine Signal (60 Hz)
f = 60; % Hz
tmin = -0.05;
tmax = 0.05;
t = linspace(tmin, tmax, 400);
x_c = cos(2*pi*f*t);

plot(t,x_c)
xlabel('t (seconds)')


% Sampling at 800 Hz
T = 1/800;

nmin = ceil(tmin/T);
nmax = floor(tmax/T);

n = nmin:nmax;

x1 = cos(2*pi*f*n*T);

hold on
plot(n*T,x1,'o')
hold off


% Sampling at 400 Hz
T = 1/400;

nmin = ceil(tmin/T);
nmax = floor(tmax/T);

n = nmin:nmax;

x1 = cos(2*pi*f*n*T);

plot(t,x_c)

hold on
plot(n*T,x1,'o')
hold off

% Sampling at Nyquist Rate (120 Hz)
T = 1/120;

nmin = ceil(tmin/T);
nmax = floor(tmax/T);

n = nmin:nmax;

x1 = cos(2*pi*f*n*T);

plot(t,x_c)

hold on
plot(n*T,x1,'o')
hold off

% Aliasing Example (Sampling at 70 Hz)
T = 1/70;

nmin = ceil(tmin/T);
nmax = floor(tmax/T);

n = nmin:nmax;

x1 = cos(2*pi*f*n*T);

plot(t,x_c)

hold on
plot(n*T,x1,'o')



% Showing Aliased 10 Hz Signal
T = 1/70;

x_c = cos(2*pi*10*t);

nmin = ceil(tmin/T);
nmax = floor(tmax/T);

n = nmin:nmax;

x1 = cos(2*pi*f*n*T);

plot(t,x_c)

hold on
plot(n*T,x1,'o')
hold off


%% Up-Sampling
clear all; close all;

% fo is normalized digital frequency
% fo = 0.1 means 0.1 cycle/sample
% 1 cycle (period) takes 1/fo=1/0.1=10 samples


N = 20;       % Input signal length
L = 3;        % Up-sampling factor
fo = .1;     % Input signal frequency

% ---- Generate input sinusoidal sequence ----
n = 0:N-1;
x = sin(2*pi*fo*n);

% ---- Up-sampling: insert (L-1) zeros between samples ----
y = zeros(1, L*length(x));
y(1:L:length(y)) = x;

% ---- Plot ----
subplot(211)
stem(n, x, 'filled');
title('Original Input Sequence x(n)');
xlabel('n'); ylabel('Amplitude');
grid on;

subplot(212)
stem(0:length(y)-1, y, 'filled');
title(['Up-sampled Sequence (L = ', num2str(L), ')']);
xlabel('n'); ylabel('Amplitude');
grid on;


%% Down-Sampling
clear all;
echo on;

N = input('Output length = ');
M = input('Down-sampling factor = ');
fo = input('Input Signal Frequency = ');

% Generate input sinusoidal sequence
n = 0:N-1;
m = 0:N*M-1;

x = sin(2*pi*fo*m);

% Generate down-sampled sequence
y = x(1:M:length(x));

% Plot
subplot(211)
stem(n,x(1:N));
title('Input Sequence');
xlabel('n');
ylabel('Amplitude');

subplot(212)
stem(n,y);
title(['Output sequence down-sampled by ',num2str(M)]);
xlabel('n');
ylabel('Amplitude');



%% Interpolation Process
clear all;
echo on;

% N=100, L=2
N = input('length of input signal = ');
L = input('Up-sampling factor = ');

f1 = input('Input Signal Frequency of first sinusoid= ');
% f1 = 0.01

f2 = input('Input Signal Frequency of second sinusoid= ');
% f2 = 0.02

% Generate input signal
n = 0:N-1;
x = sin(2*pi*f1*n) + sin(2*pi*f2*n);

% Generate interpolated output
y = interp(x,L);

% Plot
subplot(211)
stem(n,x);
title('Input Sequence');
xlabel('n');
ylabel('Amplitude');

subplot(212)
m = 0:N*L-1;
stem(m,y(1:N*L));
title('Output sequence');
xlabel('n');
ylabel('Amplitude');



%% Compare all process

clear all; close all;

N = 20; L = 4; fo = 0.05;
n = 0:N-1;
x = sin(2*pi*fo*n);

% Up-sampled (zero insertion)
y_up = zeros(1, L*length(x));
y_up(1:L:length(y_up)) = x;

% Interpolated (smooth version)
y_interp = interp(x, L);

m = 0:L*N-1;

figure;
subplot(311)
stem(n, x, 'filled'); title('Original Signal'); grid on;

subplot(312)
stem(m, y_up, 'filled'); title('Up-sampled (Zero Insertion)'); grid on;

subplot(313)
stem(m, y_interp(1:L*N), 'filled'); title('Interpolated (Smoothed)'); grid on;



%%  Sampling and Reconstruction of a Signal 

% ---------------------------------------------
% Original continuous-like signal parameters
% ---------------------------------------------
t  = 0:0.1:20;      % Fine time vector (approximates continuous time)
F1 = 0.1;            % Frequency of first sinusoid
F2 = 0.2;            % Frequency of second sinusoid
x  = sin(2*pi*F1*t) + sin(2*pi*F2*t);   % Original signal

% ---------------------------------------------
% Plot original signal
% ---------------------------------------------
figure(1);
subplot(2,1,1);
plot(t,x);
title('Original Signal x(t)');
xlabel('t'); ylabel('x(t)');
grid on;

% ---------------------------------------------
% Sampling: take every 10th point (21 samples)
% ---------------------------------------------
x_samples = x(1:10:201);   
n = 0:length(x_samples)-1;

subplot(2,1,2);
stem(n, x_samples, 'filled');
title('Sampled Signal x_s(n)');
xlabel('n'); ylabel('x_s(n)');
axis([0 20 -2 2]);
grid on;



% ---------------------------------------------
% Reconstruction using ideal sinc interpolation
% ---------------------------------------------
T = 0.1;                    % Sampling period used above (t = 0:0.1:20)
t_recon = 0:0.1:20;         % Time vector for reconstructed signal
x_recon = zeros(1, length(t_recon));

for k = 0:length(x_samples)-1
    % Each sample contributes a shifted & scaled sinc function
    l = (t_recon - k*10*T)/(10*T);   
    x_recon = x_recon + x_samples(k+1) * sinc(l);
end

% ---------------------------------------------
% Plot reconstructed signal vs original
% ---------------------------------------------
figure(2);
subplot(2,1,1);
plot(t, x, 'b'); hold on;
stem(n*10*T, x_samples, 'r', 'filled');
title('Original Signal with Sample Points');
xlabel('t'); ylabel('Amplitude');
legend('Original','Samples');
grid on;

subplot(2,1,2);
plot(t_recon, x_recon, 'k', 'LineWidth', 1.2);
title('Reconstructed Signal (via Sinc Interpolation)');
xlabel('t'); ylabel('Amplitude');
grid on;


%% Problem: 1: Modify the code to generate aliased signal from the signal x. Plot both original and aliased signal in the same scale.

clear all; close all;

% ---------------- Original Signal ----------------
t  = 0:0.01:20;                 % Fine time axis (continuous-এর প্রতিরূপ)
F1 = 0.1;
F2 = 0.2;
x  = sin(2*pi*F1*t) + sin(2*pi*F2*t);

% ---------------- Correct Sampling (Nyquist satisfied) ----------------
Ts1 = 1;                        % Fs1 = 1 Hz  (>= 2*F2 = 0.4 Hz) -> Thik ache
n1  = 0:Ts1:20;
x1  = sin(2*pi*F1*n1) + sin(2*pi*F2*n1);

% ---------------- Aliased Sampling (Nyquist violated) ----------------
Ts2 = 3;                        % Fs2 = 1/3 Hz (< 2*F2 = 0.4 Hz) -> Aliasing!
n2  = 0:Ts2:20;
x2  = sin(2*pi*F1*n2) + sin(2*pi*F2*n2);

% ---------------- Reconstruct aliased signal (sinc interpolation at Fs2) ----------------
x_alias_recon = zeros(size(t));
for k = 1:length(n2)
    x_alias_recon = x_alias_recon + x2(k)*sinc((t-n2(k))/Ts2);
end

% ---------------- Theoretical Alias Frequency ----------------
Fs2 = 1/Ts2;
F2_alias = abs(F2 - round(F2/Fs2)*Fs2);
fprintf('Sampling Fs2 = %.4f Hz,  Nyquist = %.4f Hz\n', Fs2, Fs2/2);
fprintf('F2 = %.2f Hz aliased as F2_alias = %.4f Hz\n', F2, F2_alias);

% ---------------- Plot: Original vs Aliased (same scale) ----------------
figure;
plot(t, x, 'k', 'LineWidth', 1.5); hold on;
plot(t, x_alias_recon, 'r--', 'LineWidth', 1.5);
stem(n2, x2, 'r', 'filled');
stem(n1, x1, 'bo');
legend('Original x(t)', 'Aliased reconstruction', ...
    'Aliased samples (Fs = 1/3 Hz)', 'Correctly-spaced samples (Fs = 1 Hz)');
xlabel('t'); ylabel('Amplitude');
title('Original Signal vs Aliased Signal (Same Scale)');
axis([0 20 -2.5 2.5]);
grid on;