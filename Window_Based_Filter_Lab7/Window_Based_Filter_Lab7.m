clear
clc
close all

M = 51;

w1 = bartlett_window(M);
w2 = blackman_window(M);
w3 = hamming_window(M);
w4 = hanning_window(M);

figure

subplot(2,2,1)
stem(w1,'filled')
grid on
title('Bartlett Window')

subplot(2,2,2)
stem(w2,'filled')
grid on
title('Blackman Window')

subplot(2,2,3)
stem(w3,'filled')
grid on
title('Hamming Window')

subplot(2,2,4)
stem(w4,'filled')
grid on
title('Hanning Window')




clear
clc
close all

M = 51;

beta = 5;

L = 1;

w1 = kaiser_window(M,beta);

w2 = lanczos_window(M,L);

figure

subplot(2,1,1)

stem(w1,'filled')

grid on

title('Kaiser Window')

xlabel('Samples')

ylabel('Amplitude')

subplot(2,1,2)

stem(w2,'filled')

grid on

title('Lanczos Window')

xlabel('Samples')

ylabel('Amplitude')


% Frequency Response Demor
N = 2048;

figure

freqz(w1,1,N)

title('Kaiser Window Frequency Response')

figure

freqz(w2,1,N)

title('Lanczos Window Frequency Response')


%% Window_Comparison

clear
clc
close all

% Window Length

M = 51;

% Parameters

beta = 5;

L = 1;

alpha = 0.5;

% Generate Windows

w1 = bartlett_window(M);

w2 = blackman_window(M);

w3 = hamming_window(M);

w4 = hanning_window(M);

w5 = kaiser_window(M,beta);

w6 = lanczos_window(M,L);

w7 = tukey_window(M,alpha);

% Time Domain Plots

figure

subplot(4,2,1)
stem(w1,'filled')
grid on
title('Bartlett')

subplot(4,2,2)
stem(w2,'filled')
grid on
title('Blackman')

subplot(4,2,3)
stem(w3,'filled')
grid on
title('Hamming')

subplot(4,2,4)
stem(w4,'filled')
grid on
title('Hanning')

subplot(4,2,5)
stem(w5,'filled')
grid on
title('Kaiser')

subplot(4,2,6)
stem(w6,'filled')
grid on
title('Lanczos')

subplot(4,2,7)
stem(w7,'filled')
grid on
title('Tukey')



%% Frequency_Response_Comparison

clear
clc
close all

M = 51;

beta = 5;

L = 1;

alpha = 0.5;

w{1} = bartlett_window(M);
w{2} = blackman_window(M);
w{3} = hamming_window(M);
w{4} = hanning_window(M);
w{5} = kaiser_window(M,beta);
w{6} = lanczos_window(M,L);
w{7} = tukey_window(M,alpha);

name = {'Bartlett','Blackman','Hamming','Hanning',...
    'Kaiser','Lanczos','Tukey'};


for k = 1:7
    figure (k)

    subplot(4,2,k)

    freqz(w{k},1,1024)

    title(name{k})

end


%% Magnitude Comparison

clear
clc
close all

M = 51;

beta = 5;

L = 1;

alpha = 0.5;

w{1} = bartlett_window(M);
w{2} = blackman_window(M);
w{3} = hamming_window(M);
w{4} = hanning_window(M);
w{5} = kaiser_window(M,beta);
w{6} = lanczos_window(M,L);
w{7} = tukey_window(M,alpha);

name = {'Bartlett','Blackman','Hamming','Hanning',...
    'Kaiser','Lanczos','Tukey'};

figure

hold on

for k = 1:7

    [H,f] = freqz(w{k},1,2048);

    plot(f/pi,20*log10(abs(H)))

end

grid on

xlabel('Normalized Frequency')

ylabel('Magnitude (dB)')

title('Comparison of Window Functions')

legend(name,'Location','SouthWest')