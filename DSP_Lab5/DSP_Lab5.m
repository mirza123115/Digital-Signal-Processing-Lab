clear all
close all
clc

%% ===== Example 1: DTFS Coefficients of Rectangular Pulse and Reconstruction =====

Fs = 100e3;
dt = 1/Fs;

T  = 1e-3;
D  = 0.1;
PW = D*T;
f  = 1/T;

t = -T/2 : dt : T/2;
n = t/dt;
L = PW/dt;

x = zeros(1,length(t));
x(abs(n) <= L/2) = 1.1;

figure(1)
subplot(2,1,1)
plot(t,x,'LineWidth',1.5)
grid on
xlabel('Time (Seconds)')
ylabel('x(t)')
title('Continuous Rectangular Pulse')

subplot(2,1,2)
stem(n,x,'filled')
grid on
xlabel('Sample Index (n)')
ylabel('x(n)')
title('Sampled Rectangular Pulse')

N  = length(x);
Nc = N;

if mod(Nc,2)==0
    k = -(Nc/2):(Nc/2-1);
else
    k = -((Nc-1)/2):((Nc-1)/2);
end

c = zeros(1,length(k));
for i1 = 1:length(k)
    for i2 = 1:length(x)
        c(i1) = c(i1) + (1/N)*x(i2)*exp(-1j*2*pi*k(i1)*n(i2)/N);
    end
end

figure(2)
subplot(2,1,1)
stem(k,abs(c),'filled')
grid on
xlabel('Harmonic Index (k)')
ylabel('|C_k|')
title('Magnitude Spectrum')

subplot(2,1,2)
stem(k,angle(c)*180/pi,'filled')
grid on
xlabel('Harmonic Index (k)')
ylabel('Phase (Degrees)')
title('Phase Spectrum')

t_re = -T/2 : dt : T/2;
n_re = t_re/dt;
x_re = zeros(size(n_re));

for i1 = 1:length(k)
    for i2 = 1:length(n_re)
        x_re(i2) = x_re(i2) + c(i1)*exp(1j*2*pi*k(i1)*n_re(i2)/N);
    end
end

figure(3)
subplot(2,1,1)
stem(n_re,real(x_re),'filled')
grid on
xlabel('Sample Index (n)')
ylabel('Amplitude')
title('Reconstructed Signal (Discrete)')

subplot(2,1,2)
plot(t_re,real(x_re),'LineWidth',1.5)
grid on
xlabel('Time (Seconds)')
ylabel('Amplitude')
title('Reconstructed Signal (Continuous)')


%% ===== Example 2: DTFT of a Finite-Duration Sequence x(n)={1,2,3,4,5} =====

n = -1:3; x = 1:5;
k = 0:500; w = (pi/500)*k;
X = x * (exp(-1j*pi/500)) .^ (n'*k);
magX = abs(X); angX = angle(X);
realX = real(X); imagX = imag(X);

figure(4)
subplot(2,2,1); plot(k/500,magX);grid
xlabel('frequency in pi units'); title('Magnitude Part')

subplot(2,2,3); plot(k/500,angX/pi);grid
xlabel('frequency in pi units'); title('Angle Part')

subplot(2,2,2); plot(k/500,realX);grid
xlabel('frequency in pi units'); title('Real Part')

subplot(2,2,4); plot(k/500,imagX);grid
xlabel('frequency in pi units'); title('Imaginary Part')




%% Example-3 DISCRETE TIME FOURIER TRANSFORM (DTFT)

clear;
clc;
close all;

% ------------------------------------------------------------
% Define Input Sequence
% ------------------------------------------------------------

x = [1 3 -9 5 10];

% ------------------------------------------------------------
% Define Sample Indices
% ------------------------------------------------------------

n1 = -1;                     % First sample index
n2 = 3;                      % Last sample index
n  = n1:n2;                  % Time index vector

% ------------------------------------------------------------
% Define Frequency Grid
% ------------------------------------------------------------

M = 500;                     % Number of frequency samples

w = (-M/2:M/2) * (2*pi/M);   % Frequency vector (radians/sample)

% ------------------------------------------------------------
% Construct DTFT Matrix
% ------------------------------------------------------------

W = exp(-1j * w.' * n);

% ------------------------------------------------------------
% Compute DTFT
% ------------------------------------------------------------

X = W * x.';

% ------------------------------------------------------------
% Plot Magnitude Spectrum
% ------------------------------------------------------------

figure;

subplot(2,1,1)

plot(w/(2*pi), abs(X), 'k', 'LineWidth', 1.5);

grid on;

xlabel('Normalized Frequency');

ylabel('|X(f)|');

title('Magnitude Spectrum');

% ------------------------------------------------------------
% Plot Phase Spectrum
% ------------------------------------------------------------

subplot(2,1,2)

plot(w/(2*pi), angle(X)*180/pi, 'k', 'LineWidth', 1.5);

grid on;

xlabel('Normalized Frequency');

ylabel('Phase (Degrees)');

title('Phase Spectrum');



%% ===== Example 4: DFS of Periodic Square Wave (Loop-based, 4 cases) =====
clear all
close all
clc

L_vec = [5  5  5  7];     % pulse width values
N_vec = [20 40 60 60];    % period values

figure;

for idx = 1:length(L_vec)
    L = L_vec(idx);
    N = N_vec(idx);
    k = -N/2:N/2;
    
    xn = [ones(1,L), zeros(1,N-L)];
    Xk = dfs(xn,N);
    magXk = abs([Xk(N/2+1:N) Xk(1:N/2+1)]);
    
    subplot(2,2,idx);
    stem(k,magXk);
    axis([-N/2, N/2, -0.5, 5.5])
    xlabel('k'); ylabel('|Xtilde(k)|')
    title(['DFS of SQ. wave: L=', num2str(L), ', N=', num2str(N)])
end



%% ===== Example 5: Sampling Z-transform on Unit Circle (Loop-based, N=5,10,20,50) =====

clear all
close all
clc


N_vec = [5 10 20 50];
n_true = 0:49;
x_true = (0.7).^n_true;   % আসল non-periodic সিগন্যাল

figure;
for idx = 1:length(N_vec)
    N = N_vec(idx);
    k = 0:N-1;
    wk = 2*pi*k/N;
    zk = exp(1j*wk);
    Xk = zk./(zk-0.7);
    xn = real(idfs(Xk,N));
    
    subplot(2,2,idx);
    stem(0:N-1, xn, 'filled'); hold on;
    plot(n_true(1:N), x_true(1:N), 'r--', 'LineWidth', 1.5);
    legend('Aliased \tilde{x}(n)', 'True x(n) = (0.7)^n');
    title(['N = ', num2str(N)]);
    xlabel('n'); ylabel('Amplitude');
    grid on;
end

%% ===== Example 6: 4-point DFT of x(n) = {1,1,1,1} =====
clear all
close all
clc

x = [1,1,1,1]; N = 4;

% ---- Discrete DFT (4 points) ----
X = dft(x,N);
magX = abs(X);
phaX = angle(X)*180/pi;

% ---- Continuous DTFT (fine frequency grid, for the dashed envelope) ----
w = linspace(0, 2*pi, 500);      % continuous frequency 0 to 2*pi
Xw = zeros(1,length(w));
for i = 1:length(w)
    n = 0:N-1;
    Xw(i) = sum(x .* exp(-1j*w(i)*n));
end
k_continuous = w*N/(2*pi);        % convert w to k-scale (0 to N)

magXw = abs(Xw);
phaXw = angle(Xw)*180/pi;

% ---- Plot: Magnitude ----
figure;
subplot(2,1,1)
plot(k_continuous, magXw, 'k--'); hold on;
stem(0:N-1, magX, 'o');
xlabel('k'); ylabel('|X(k)|');
title('Magnitude of the DFT: N=4');
axis([0 4 -1 5]);
grid on;

% ---- Plot: Phase ----
subplot(2,1,2)
plot(k_continuous, phaXw, 'k--'); hold on;
stem(0:N-1, phaX, 'o');
xlabel('k'); ylabel('Degrees');
title('Angle of the DFT: N=4');
axis([0 4 -200 200]);
grid on;


%% ===== Example 7: FFT-based Amplitude Modulation and Demodulation =====
clear all;
echo on;
t0 = 0.2;
ts = 8.3333e-004;
fc = 250;
fs = 1/ts;
df = 0.3;
t = [-t0/2:ts:t0/2];
m = sinc(100*t);          % message signal
subplot(241)
plot(t,m)
xlabel('t')
ylabel('Amplitude')
title('Message Signal')

c = cos(2*pi*fc*t);       % carrier
u = m.*c;                  % modulation
[M,m,df1] = fftseq(m,ts,df);
M = M/fs;
[C,m,df1] = fftseq(c,ts,df);
C = C/fs;
[U,u1,df1] = fftseq(u,ts,df);
U = U/fs;
f = [0:df1:df1*(length(m)-1)]-fs/2;

subplot(242)
plot(f,abs(fftshift(M)))
xlabel('f')
ylabel('Amplitude')
title('Spectrum of the Message Signal')

subplot(243)
plot(f,abs(fftshift(C)))
xlabel('f')
ylabel('Amplitude')
title('Spectrum of the carrier Signal')

subplot(244)
plot(f,abs(fftshift(U)))
xlabel('f')
ylabel('Amplitude')
title('Spectrum of the Modulated Signal')

d = u.*c;                  % demodulation
[D,m,df1] = fftseq(d,ts,df);
D = D/fs;

subplot(245)
plot(f,abs(fftshift(D)));
xlabel('f')
ylabel('Amplitude')
title('Spectrum of the demodulated Signal')

f_cutoff = 100;
n_cutoff = floor(f_cutoff/df1);
H = zeros(size(f));
H(1:n_cutoff) = 2*ones(1,n_cutoff);
H(length(f)-n_cutoff +1:length(f)) = 2*ones(1,n_cutoff);  % lowpass filter

subplot(246)
plot(f*df,abs(fftshift(H)))
xlabel('f')
ylabel('Amplitude')
title('Spectrum of the Lowpass Filter')

DEM = D.*H;
subplot(247)
plot(f,abs(fftshift(DEM)))
xlabel('f')
ylabel('Amplitude')
title('Spectrum of the Reconstructed Message Signal')

dem = real(ifft(DEM))*fs;
subplot(248)
plot(t,dem(1:length(t)))
xlabel('t')
ylabel('Amplitude')
title('Reconstructed Message Signal')