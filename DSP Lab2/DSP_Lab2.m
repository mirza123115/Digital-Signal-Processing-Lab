% ---------------------------------------------------------
% Manual zero padding with index vectors
% ---------------------------------------------------------

clc;
clear;
close all;

% Original sequences
x1 = [1 2 3 4];
n1 = [-1 0 1 2];

x2 = [4 3 2 1];
n2 = [2 3 4 5];

% Common index range
n = -1:5;

% Zero padded sequences
x1_pad = [1 2 3 4 0 0 0];
x2_pad = [0 0 0 4 3 2 1];

% Addition
y_add = x1_pad + x2_pad;

% Multiplication
y_mul = x1_pad .* x2_pad;

% Display
disp('n1 = ');
disp(n1);

disp('x1 = ');
disp(x1);

disp('n2 = ');
disp(n2);

disp('x2 = ');
disp(x2);

disp('Common index n = ');
disp(n);

disp('Zero padded x1 = ');
disp(x1_pad);

disp('Zero padded x2 = ');
disp(x2_pad);

disp('Addition result = ');
disp(y_add);

disp('Multiplication result = ');
disp(y_mul);

% Plot
figure;

subplot(2,2,1);
stem(n,x1_pad);
title('Zero Padded x1');
xlabel('n');
ylabel('Amplitude');
grid on;

subplot(2,2,2);
stem(n,x2_pad);
title('Zero Padded x2');
xlabel('n');
ylabel('Amplitude');
grid on;

subplot(2,2,3);
stem(n,y_add);
title('Addition');
xlabel('n');
ylabel('Amplitude');
grid on;

subplot(2,2,4);
stem(n,y_mul);
title('Multiplication');
xlabel('n');
ylabel('Amplitude');
grid on;


% ---------------------------------------------------------
% Test program for sequence addition function sigadd
% ---------------------------------------------------------

clc;
clear;
close all;

% First sequence
x1 = [1 2 3 4];
n1 = [-1 0 1 2];

% Second sequence
x2 = [4 3 2 1];
n2 = [2 3 4 5];

% Call function
[y,n] = sigadd(x1,n1,x2,n2);

% Display result
disp('Result of sequence addition:');
disp(y);

% Plot result
figure;
stem(n,y);

xlabel('n');
ylabel('Amplitude');
title('Addition of Two Sequences');

grid on;



% ---------------------------------------------------------
% Test program for sequence multiplication function sigmult
% ---------------------------------------------------------

clc;
clear;
close all;

% First sequence
x1 = [1 2 3 4];
n1 = [-1 0 1 2];

% Second sequence
x2 = [4 3 2 1];
n2 = [2 3 4 5];

% Call function
[y,n] = sigmult(x1,n1,x2,n2);

% Display result
disp('Result of sequence multiplication:');
disp(y);

% Plot
figure;
stem(n,y);

xlabel('n');
ylabel('Amplitude');
title('Multiplication of Two Sequences');

grid on;



% ---------------------------------------------------------
% Test program for impulse sequence function impseq
% ---------------------------------------------------------

clc;
clear;
close all;

[x,n] = impseq(0,-5,5);

stem(n,x);

xlabel('n');
ylabel('Amplitude');
title('Unit Impulse Sequence');

grid on;


% ---------------------------------------------------------
% Test program for unit step sequence function stepseq
% ---------------------------------------------------------

clc;
clear;
close all;

[x,n] = stepseq(0,-5,5);

stem(n,x);

xlabel('n');
ylabel('Amplitude');
title('Unit Step Sequence');

grid on;



% ---------------------------------------------------------
% Generate periodic sequence
% ---------------------------------------------------------

clc;
clear;
close all;

% Original sequence
S = [1 2 3];

% Number of repetitions
N = 4;

% Generate periodic sequence
x = repmat(S,1,N);

% Sample index
n = 0:length(x)-1;

% Plot
stem(n,x);

xlabel('n');
ylabel('Amplitude');
title('Periodic Sequence');

grid on;



% ---------------------------------------------------------
% Generate periodic cosine sequence
% ---------------------------------------------------------

clc;
clear;
close all;

% Number of repetitions
N = 3;

% One period of cosine signal
y = cos(2*pi*(0:10)/11);

% Generate periodic sequence
ny = MakePeriodicSeq(y,N);

% Sample index
n = 0:length(ny)-1;

% Plot
figure;
stem(n,ny);

xlabel('n');
ylabel('Amplitude');
title('Periodic Cosine Sequence');

grid on;



% ---------------------------------------------------------
% Test program for folding
% ---------------------------------------------------------

clc;
clear;
close all;

% Original sequence
x = [1 2 3 4];
n = [3 4 5 6];

% Fold sequence
[y,nf] = sigfold(x,n);

% Plot original signal
subplot(2,1,1);
stem(n,x);

title('Original Sequence');
xlabel('n');
ylabel('Amplitude');

grid on;

% Plot folded signal
subplot(2,1,2);
stem(nf,y);

title('Folded Sequence');
xlabel('n');
ylabel('Amplitude');

grid on;


% ---------------------------------------------------------
% Test program for shifting
% ---------------------------------------------------------

clc;
clear;
close all;

% Original sequence
x = [1 2 3 4];
m = [0 1 2 3];

% Shift amount
n0 = 2;

% Shift sequence
[y,n] = sigshift(x,m,n0);

% Plot
subplot(2,1,1);
stem(m,x);

title('Original Sequence');
xlabel('n');
ylabel('Amplitude');

grid on;

subplot(2,1,2);
stem(n,y);

title('Shifted Sequence');
xlabel('n');
ylabel('Amplitude');

grid on;


% ---------------------------------------------------------
% Test program for even and odd decomposition
% ---------------------------------------------------------

clc;
clear;
close all;

% Original sequence
x = [1 2 3 4 5];
n = -2:2;

% Compute even and odd parts
[xe,xo,n] = evenodd(x,n);

% Plot original signal
subplot(3,1,1);
stem(n,x);

title('Original Sequence');
xlabel('n');
ylabel('Amplitude');

grid on;

% Plot even part
subplot(3,1,2);
stem(n,xe);

title('Even Component');
xlabel('n');
ylabel('Amplitude');

grid on;

% Plot odd part
subplot(3,1,3);
stem(n,xo);

title('Odd Component');
xlabel('n');
ylabel('Amplitude');

grid on;



% ---------------------------------------------------------
% Convolution using MATLAB conv() function
% ---------------------------------------------------------

clc;
clear;
close all;

% Input sequence x(n)
x = [3 11 7 0 -1 4 2];
nx = -3:3;

% Impulse response h(n)
h = [2 3 0 -5 2 1];
nh = -1:4;

% Perform convolution
y = conv(x,h);

% Output index range
nyb = nx(1) + nh(1);      % Beginning index
nye = nx(end) + nh(end);  % Ending index

% Output index vector
ny = nyb:nye;

% Display output
disp('Output sequence y(n) = ');
disp(y);

disp('Output index ny = ');
disp(ny);

% Plot output
figure;
stem(ny,y);

xlabel('n');
ylabel('Amplitude');
title('Convolution of x(n) and h(n)');

grid on;



% ---------------------------------------------------------
% Test program for modified convolution
% ---------------------------------------------------------

clc;
clear;
close all;

% Sequence x(n)
x = [3 11 7 0 -1 4 2];
nx = -3:3;

% Sequence h(n)
h = [2 3 0 -5 2 1];
nh = -1:4;

% Call modified convolution function
[y,ny] = conv_m(x,nx,h,nh);

% Display result
disp('Convolution output y(n) = ');
disp(y);

disp('Output index ny = ');
disp(ny);

% Plot
figure;
stem(ny,y);

xlabel('n');
ylabel('Amplitude');
title('Modified Convolution Output');

grid on;



% ---------------------------------------------------------
% Crosscorrelation 
% ---------------------------------------------------------

clc;
clear;
close all;

% Prototype signal
x = [3 11 7 0 -1 4 2];

% Shifted + noise signal
x_shift = [0 0 x];          % shift by 2
w = randn(1,length(x_shift));
y = x_shift + w;

% Cross correlation
[r,lags] = xcorr(y,x);

% Plot
figure;
stem(lags,r);

xlabel('Lag');
ylabel('Amplitude');
title('Crosscorrelation r_{yx}(l)');

grid on;


%% ========================================================
% PART 2: IMPULSE RESPONSE AND STEP RESPONSE
% ========================================================

% System coefficients (given difference equation)
p = [0.8 0.44 -0.36 0.02];   % numerator (x terms)
d = [1 -0.7 0.45 0.6];       % denominator (y terms)

% Desired length
N = 41;

% ---------------- Impulse Response ----------------
x_imp = [1 zeros(1, N-1)];   % delta(n)

y_imp = filter(p, d, x_imp);

n = 0:N-1;

figure;
subplot(2,1,1);
stem(n, y_imp);
xlabel('Time index n');
ylabel('Amplitude');
title('Impulse Response');
grid on;

% ---------------- Step Response ----------------
x_step = ones(1, N);         % unit step

y_step = filter(p, d, x_step);

subplot(2,1,2);
stem(n, y_step);
xlabel('Time index n');
ylabel('Amplitude');
title('Step Response');
grid on;




clc;
clear;
close all;

x = [1 2 3 4 5 6 7 6 5 4 3 2 1];
n = -2:10;

% 2x(n-5)
[xa,na] = sigshift(x,n,5);
xa = 2*xa;

% -3x(n+4)
[xb,nb] = sigshift(x,n,-4);
xb = -3*xb;

% Addition
[x1,n1] = sigadd(xa,na,xb,nb);

figure;
stem(n1,x1,'filled');
grid on;
title('Problem 1(a): x_1(n)=2x(n-5)-3x(n+4)');
xlabel('n');
ylabel('Amplitude');


% x(3-n)

[xf,nf] = sigfold(x,n);
[xa,na] = sigshift(xf,nf,3);

% x(n-2)

[xb,nb] = sigshift(x,n,2);

% x(n)x(n-2)

[xc,nc] = sigmult(x,n,xb,nb);

% x(3-n)+x(n)x(n-2)

[x2,n2] = sigadd(xa,na,xc,nc);

figure;
stem(n2,x2,'filled');
grid on;
title('Problem 1(b)');
xlabel('n');
ylabel('Amplitude');


clc;
clear;

n = 0:25;
x1 = zeros(size(n));

for m = 0:10

    [d1,nd1] = impseq(2*m,0,25);
    [d2,nd2] = impseq(2*m+1,0,25);

    temp = (m+1)*(d1-d2);

    x1 = x1 + temp;

end

figure;
stem(n,x1,'filled');
grid on;
title('Problem 2(a)');
xlabel('n');
ylabel('Amplitude');



clc;
clear;

n = -10:15;

[u1,~] = stepseq(-5,-10,15);
[u2,~] = stepseq(6,-10,15);

term1 = n.^2 .* (u1-u2);

[d,~] = impseq(0,-10,15);

term2 = 10*d;

[u3,~] = stepseq(4,-10,15);
[u4,~] = stepseq(10,-10,15);

term3 = 20*(0.5).^n .* (u3-u4);

x2 = term1 + term2 + term3;

figure;
stem(n,x2,'filled');
grid on;
title('Problem 2(b)');
xlabel('n');
ylabel('Amplitude');



clc;
clear;

n = 0:30;

x = (0.8).^n;

[y,ny] = conv_m(x,n,x,n);

figure;
stem(ny,y,'filled');
grid on;
title('Problem 3');
xlabel('n');
ylabel('Amplitude');




clc;
clear;

clc;
clear;

x = [1 -2 4 6 -5 8 10];
nx = 0:6;

h = [2 3 0 -5 2 1];
nh = -1:4;

[y,ny] = conv_m(x,nx,h,nh);

figure;
stem(ny,y,'filled');
grid on;
title('Convolution x(n)*h(n)');
xlabel('n');
ylabel('Amplitude');



[hf,nhf] = sigfold(h,nh);

[r,nr] = conv_m(x,nx,hf,nhf);

figure;
stem(nr,r,'filled');
grid on;
title('Cross Correlation');
xlabel('Lag');
ylabel('Correlation');