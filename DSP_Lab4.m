clear all
close all
clc

%% ===== Example 1: Inverse Z-transform using Power Series (deconv) =====
b = [1 2 1];
a = [1 -1 0.3561];
n = 5;
b = [b zeros(1,n-1)];
[x,r] = deconv(b,a);
disp(x)


%% ===== Example 2: Inverse Z-transform of Multiple N/D pairs (sos2tf + deconv) =====
n = 5;   % number of power series points
N1 = [1 -1.122346 1];
D1 = [1 -1.433509 0.858111];
N2 = [1 1.474597 1];
D2 = [1 -1.293601 0.556929];
N3 = [1 1 0];
D3 = [1 -0.612159 0];
B = [N1;
    N2;
    N3];
A = [D1;
    D2;
    D3];
[b,a] = sos2tf([B A]);
b = [b zeros(1,n-1)];
[x,r] = deconv(b,a);
disp(x)


%% ===== Example 3: Partial Fraction Expansion (residuez) =====
[r,p,k] = residuez([1 2 1],[1 -1 0.3561])


%% ===== Example 4: Partial Fraction of Multiple N/D pairs (sos2tf + residuez) =====
N1 = [1 -1.122346 1];
N2 = [1 -0.437833 1];
N3 = [1 1 0];
D1 = [1 -1.433509 0.85811];
D2 = [1 -1.293601 0.556929];
D3 = [1 -0.612159 1];
sos = [N1 D1;
    N2 D2;
    N3 D3];
[b,a] = sos2tf(sos);
[r,p,k] = residuez(b,a)


%% ===== Example 5: Pole-Zero Diagram (zplane) =====
b = [1 -1.6180 1];
a = [1 -1.5161 0.878];
zplane(b,a)

% ---- Alternative: Find poles/zeros directly using roots ----
b = [1 -1.618 1];
a = [1 -1.5161 0.878];
zk = roots(b);
pk = roots(a);
B = poly(zk);
A = poly(pk);


%% ===== Example 6: Frequency Response (freqz) =====
b = [1 -1.6180 1];
a = [1 -1.5161 0.878];
freqz(b,a,256,500);


%% ===== Example 7: Cascade-to-Parallel Structure Conversion =====
nstage = 2;
N1 = [1 0.481199 1];
N2 = [1 1.474597 1];
D1 = [1 0.052921 0.831731];
D2 = [1 -0.304609 0.238865];
sos = [N1 D1;
    N2 D2];
[b,a] = sos2tf(sos);
[c,p,k] = residuez(b,a);
m = length(b);
b0 = b(m)/a(m);
j = 1;
for i = 1:nstage
    bk(j) = c(j) + c(j+1);
    bk(j+1) = -(c(j)*p(j+1) + c(j+1)*p(j));
    ak(j) = -(p(j) + p(j+1));
    ak(j+1) = p(j)*p(j+1);
    j = j + 2;
end
b0
ak
bk
c
p
k



%% Problem 1

clear all; close all;

% ---------------- Analytical Solution ----------------
r = 0.8;
theta = pi/4;
n = 0:20;
x_analytical = (r.^n) .* (cos(n*theta) + 2*sin(n*theta));

% ---------------- Verification using deconv (power series) ----------------
b = [1, 0.4*sqrt(2)];
a = [1, -0.8*sqrt(2), 0.64];

% ---- length ঠিক রাখার জন্য সংশোধন ----
N_points = length(n);                                  % কতগুলো point দরকার
b_ext = [b, zeros(1, N_points + length(a) - length(b) - 1)];  % সঠিক padding
[x_deconv, ~] = deconv(b_ext, a);
x_deconv = x_deconv(1:N_points);   % প্রয়োজনীয় length এ কেটে নেওয়া

% ---------------- Verification using residuez ----------------
[res, poles, k] = residuez(b, a);
disp('Poles:'); disp(poles);
disp('Residues:'); disp(res);

% ---------------- Verification using filter() ----------------
impulse_input = [1, zeros(1,length(n)-1)];
x_filter = filter(b, a, impulse_input);

% ---------------- Compare all three methods ----------------
figure;
subplot(311)
stem(n, x_analytical, 'filled');
title('Analytical Solution: x(n) = (0.8)^n[cos(n\pi/4)+2sin(n\pi/4)]');
xlabel('n'); ylabel('x(n)'); grid on;

subplot(312)
stem(n, x_deconv, 'filled', 'r');
title('Power Series Method (deconv)');
xlabel('n'); ylabel('x(n)'); grid on;

subplot(313)
stem(n, x_filter, 'filled', 'g');
title('Filter Method (filter)');
xlabel('n'); ylabel('x(n)'); grid on;

% ---------------- Numerical error check ----------------
fprintf('Max error (Analytical vs Filter): %e\n', max(abs(x_analytical - x_filter)));
fprintf('Max error (Analytical vs Deconv): %e\n', max(abs(x_analytical - x_deconv)));



%% Problem 2

clear all; close all;

% ---------------- System coefficients ----------------
b = [1];           % numerator: X(z) coefficient
a = [1, -0.9];      % denominator: 1 - 0.9 z^-1

% ---------------- (a) Pole-Zero Plot ----------------
figure;
subplot(2,2,1);
zplane(b,a);
title('(a) Pole-Zero Plot of H(z)');
grid on;

% ---------------- (b) Frequency Response ----------------
[H, w] = freqz(b, a, 512);

subplot(2,2,2);
plot(w/pi, abs(H), 'LineWidth', 1.5);
title('(b) Magnitude Response |H(e^{j\omega})|');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('|H(e^{j\omega})|');
grid on;

subplot(2,2,3);
plot(w/pi, angle(H)*180/pi, 'LineWidth', 1.5);
title('(b) Phase Response \angle H(e^{j\omega})');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Phase (degrees)');
grid on;

% ---------------- (c) Impulse Response ----------------
N = 30;
n = 0:N-1;
impulse_input = [1, zeros(1, N-1)];
h_n = filter(b, a, impulse_input);

% Analytical form: h(n) = (0.9)^n u(n)
h_analytical = (0.9).^n;

subplot(2,2,4);
stem(n, h_n, 'filled');
hold on;
plot(n, h_analytical, 'r--', 'LineWidth', 1.2);
title('(c) Impulse Response h(n) = (0.9)^n u(n)');
xlabel('n'); ylabel('h(n)');
legend('filter() output','Analytical (0.9)^n');
grid on;

% ---------------- Verify Analytical vs filter() output ----------------
fprintf('Max error between filter() and analytical h(n): %e\n', ...
    max(abs(h_n - h_analytical)));