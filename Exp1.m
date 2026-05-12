% ---------------------------------------------------------
% Sampling a 2-Hz sine wave every 0.05 second
% Time interval: 0 to 1.1 second
% ---------------------------------------------------------

clc;
clear;
close all;

% Sampling parameters
T = 0.05;              % Sampling period
t = 0:T:1.1;           % Time vector

% Generate sampled sine wave
x = sin(2*pi*2*t);     % 2-Hz sine wave

% Plot sampled signal
figure;
stem(t, x);

% Labels and title
xlabel('Time (seconds)');
ylabel('Amplitude');
title('Samples of a 2-Hz Sine Wave');

grid on;




% ---------------------------------------------------------
% Same sine wave using sample index n
% ---------------------------------------------------------

clc;
clear;
close all;

% Sampling parameters
T = 0.05;          % Sampling period
n = 0:22;          % Sample index

% Generate sine wave
x = sin(2*pi*2*n*T);

% Plot
figure;
stem(n*T, x);

xlabel('Time (seconds)');
ylabel('Amplitude');
title('2-Hz Sine Wave Samples Using Sample Index');

grid on;



% ---------------------------------------------------------
% Two cycles of sine wave over 16 samples
% ---------------------------------------------------------

clc;
clear;
close all;

N = 16;           % Total samples
k = 2;            % Number of cycles

n = 0:N-1;        % Sample index

% Generate sine sequence
x = sin(2*pi*n*k/N);

% Plot
figure;
stem(n, x);

xlabel('Sample Index n');
ylabel('Amplitude');
title('Two Cycles of Sine Wave Over 16 Samples');

grid on;



% ---------------------------------------------------------
% Sine wave with and without phase angle
% ---------------------------------------------------------

clc;
clear;
close all;

n = 0:17;     % Sample index

% (a) Sine wave with zero phase
y1 = sin(2*pi*n/18*3);

subplot(3,1,1);
stem(n, y1);
title('Sine Wave: 3 Cycles Over 18 Samples');
xlabel('Sample');
ylabel('Amplitude');
grid on;

% (b) Sine wave with phase shift pi/2
y2 = sin(2*pi*n/18*3 + pi/2);

subplot(3,1,2);
stem(n, y2);
title('Sine Wave with Phase Shift \pi/2');
xlabel('Sample');
ylabel('Amplitude');
grid on;

% (c) Cosine wave
y3 = cos(2*pi*n/18*3);

subplot(3,1,3);
stem(n, y3);
title('Cosine Wave: 3 Cycles Over 18 Samples');
xlabel('Sample');
ylabel('Amplitude');
grid on;




% ---------------------------------------------------------
% Problem 1
% Plot x(n) = cos(w0*n) for different values of w0
% ---------------------------------------------------------

clc;
clear;
close all;

% Sample index
n = 0:20;

% Different frequency values
w = [0 pi/8 pi/4 pi/2 pi];

% Create figure
figure;

% Loop for plotting
for k = 1:length(w)

    % Generate cosine signal
    x = cos(w(k)*n);

    % Create subplot
    subplot(5,1,k);

    % Plot discrete signal
    stem(n, x);

    % Title
    title(['x(n) = cos(\omega_0 n),  \omega_0 = ', num2str(w(k))]);

    xlabel('n');
    ylabel('Amplitude');

    grid on;

end



% ---------------------------------------------------------
% Problem 2 (i)
% Exponential signal for real C and real a
% ---------------------------------------------------------

clc;
clear;
close all;

% Sample index
n = 0:15;

% Constant C
C = 1;

% Different values of a
a = [1.5 0.5 1 -1.5 -0.5 -1];

% Create figure
figure;

for k = 1:length(a)

    % Generate signal
    x = C*(a(k).^n);

    % Subplot
    subplot(3,2,k);

    % Plot
    stem(n, x);

    % Title
    title(['a = ', num2str(a(k))]);

    xlabel('n');
    ylabel('Amplitude');

    grid on;

end



% ---------------------------------------------------------
% Problem 2 (ii)
% Complex C and complex a with unity magnitude
% ---------------------------------------------------------

clc;
clear;
close all;

% Sample index
n = 0:40;

% Parameters
A = 1;
phi = pi/4;
w0 = pi/8;

% Complex C
C = A*exp(1j*phi);

% Complex a with unity magnitude
a = exp(1j*w0);

% Generate signal
x = C*(a.^n);

% Plot real part
subplot(2,1,1);
stem(n, real(x));

title('Real Part of x(n)');
xlabel('n');
ylabel('Amplitude');

grid on;

% Plot imaginary part
subplot(2,1,2);
stem(n, imag(x));

title('Imaginary Part of x(n)');
xlabel('n');
ylabel('Amplitude');

grid on;



% ---------------------------------------------------------
% Problem 2 (iii) : sigma0 > 0
% Growing complex exponential
% ---------------------------------------------------------

clc;
clear;
close all;

% Sample index
n = 0:25;

% Parameters
A = 1;
theta = pi/6;

sigma0 = 0.08;
w0 = pi/8;

% Complex C
C = A*exp(1j*theta);

% Complex a
a = exp(sigma0 + 1j*w0);

% Signal
x = C*(a.^n);

% Plot magnitude
figure;
stem(n, abs(x));

title('Magnitude of x(n) for \sigma_0 > 0');
xlabel('n');
ylabel('|x(n)|');

grid on;



% ---------------------------------------------------------
% Problem 2 (iii) : sigma0 < 0
% Decaying complex exponential
% ---------------------------------------------------------

clc;
clear;
close all;

% Sample index
n = 0:25;

% Parameters
A = 1;
theta = pi/6;

sigma0 = -0.08;
w0 = pi/8;

% Complex C
C = A*exp(1j*theta);

% Complex a
a = exp(sigma0 + 1j*w0);

% Signal
x = C*(a.^n);

% Plot magnitude
figure;
stem(n, abs(x));

title('Magnitude of x(n) for \sigma_0 < 0');
xlabel('n');
ylabel('|x(n)|');

grid on;