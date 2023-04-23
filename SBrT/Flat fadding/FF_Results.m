clear; close all; clc;

EbN0dB = -10:0.5:15;
 
% 16 símbolos => CR = 4 (8 símbolos em cada constelação) tot: 16 símbolos,
% 2 vetores  (após kronecker => 64 símbolos) 
SISO_RAYL_BPSK = [];
SISO_RICE_BPSK = [];

SISO_RAW_RAYL_BPSK = [];
SISO_RAW_RICE_BPSK = [];

% 16 símbolos => CR = 4 (8 símbolos em cada constelação) tot: 16 símbolos,
% 2 vetores (após kronecker => 64 símbolos) 
SISO_RAYL_QPSK = [];
SISO_RICE_QPSK = [];

SISO_RAW_RAYL_QPSK = [];
SISO_RAW_RICE_QPSK = [];

% 9 símbolos => CR = 3 (3 símbolos em cada constelação) 
% 3 vetores (após kronecker => 27 símbolos) 
SISO_RAYL_8PSK = [];
SISO_RICE_8PSK = [];

SISO_RAW_RAYL_8PSK = [];
SISO_RAW_RICE_8PSK = [];

% 8 símbolos => CR = 2 (2 símbolos em cada constelação) 
% 4 vetores (após kronecker => 16 símbolos) 
SISO_RAYL_16PSK = [];
SISO_RICE_16PSK = [];

SISO_RAW_RAYL_16PSK = [];
SISO_RAW_RICE_16PSK = [];

% 10 símbolos => CR = 3.2 (2 símbolos em cada constelação)
% 5 vetores (após kronecker => 32 símbolos)
SISO_RAYL_32PSK = [];
SISO_RICE_32PSK = [];

SISO_RAW_RAYL_32PSK = [];
SISO_RAW_RICE_32PSK = [];

% 12 símbolos => CR = 5.3 (2 símbolos em cada constelação)
% 6 vetores (após kronecker => 64 símbolos)
SISO_RAYL_64PSK = [];
SISO_RICE_64PSK = [];

SISO_RAW_RAYL_64PSK = [];
SISO_RAW_RICE_64PSK = [];



%% Rayleigh Plotting
t = tiledlayout(3,3);

nexttile
semilogy(EbN0dB, SISO_RAYL_BPSK, 'Color', 'Red'); 
hold on
semilogy(EbN0dB, SISO_RAW_RAYL_BPSK, 'Color', 'Blue')
xlabel("Eb/N0");
ylabel("BER");

ylim([1e-5 1e0])
xlim([EbN0dB(1) 25])

legend({'BPSK-LSKF-Rayleigh', 'Theoretical error for BPSK-Rayleigh'})
grid on
hold off


nexttile
semilogy(EbN0dB, SISO_RAYL_QPSK, 'Color', 'Red'); 
hold on
semilogy(EbN0dB, SISO_RAW_RAYL_QPSK, 'Color', 'Blue')
xlabel("Eb/N0");
ylabel("BER");

ylim([1e-5 1e0])
xlim([EbN0dB(1) 25])

legend({'QPSK-LSKF-Rayleigh', 'Theoretical error for QPSK-Rayleigh'})
grid on
hold off


nexttile
semilogy(EbN0dB, SISO_RAYL_8PSK, 'Color', 'Red'); 
hold on
semilogy(EbN0dB, SISO_RAW_RAYL_8PSK, 'Color', 'Blue')
xlabel("Eb/N0");
ylabel("BER");

ylim([1e-4 1e0])
xlim([EbN0dB(1) 25])

legend({'8PSK-LSKF-Rayleigh', 'Theoretical error for 8PSK-Rayleigh'})
grid on
hold off


nexttile
semilogy(EbN0dB, SISO_RAYL_16PSK, 'Color', 'Red'); 
hold on
semilogy(EbN0dB, SISO_RAW_RAYL_16PSK, 'Color', 'Blue')
xlabel("Eb/N0");
ylabel("BER");

ylim([1e-4 1e0])
xlim([EbN0dB(1) 25])

legend({'16PSK-LSKF-Rayleigh', 'Theoretical error for 16PSK-Rayleigh'})
grid on
hold off

nexttile
semilogy(EbN0dB, SISO_RAYL_32PSK, 'Color', 'Red'); 
hold on
semilogy(EbN0dB, SISO_RAW_RAYL_32PSK, 'Color', 'Blue')
xlabel("Eb/N0");
ylabel("BER");

ylim([1e-4 1e0])
xlim([EbN0dB(1) 35])

legend({'32PSK-LSKF-Rayleigh', 'Theoretical error for 32PSK-Rayleigh'})
grid on
hold off

nexttile
semilogy(EbN0dB, SISO_RAYL_64PSK, 'Color', 'Red'); 
hold on
semilogy(EbN0dB, SISO_RAW_RAYL_64PSK, 'Color', 'Blue')
xlabel("Eb/N0");
ylabel("BER");

ylim([6e-5 1e0])
xlim([EbN0dB(1) 35])

legend({'64PSK-LSKF-Rayleigh', 'Theoretical error for 64PSK-Rayleigh'})
grid on
hold off

%% Rice Plotting
t = tiledlayout(3,3);

nexttile
semilogy(EbN0dB, SISO_RICE_BPSK, 'Color', 'Red'); 
hold on
semilogy(EbN0dB, SISO_RAW_RICE_BPSK, 'Color', 'Blue')
xlabel("Eb/N0");
ylabel("BER");

ylim([1e-5 1e0])
xlim([EbN0dB(1) 25])

legend({'BPSK-LSKF-RICE', 'Theoretical error for BPSK-RICE'})
grid on
hold off


nexttile
semilogy(EbN0dB, SISO_RICE_QPSK, 'Color', 'Red'); 
hold on
semilogy(EbN0dB, SISO_RAW_RICE_QPSK, 'Color', 'Blue')
xlabel("Eb/N0");
ylabel("BER");

ylim([1e-5 1e0])
xlim([EbN0dB(1) 25])

legend({'QPSK-LSKF-RICE', 'Theoretical error for QPSK-RICE'})
grid on
hold off


nexttile
semilogy(EbN0dB, SISO_RICE_8PSK, 'Color', 'Red'); 
hold on
semilogy(EbN0dB, SISO_RAW_RICE_8PSK, 'Color', 'Blue')
xlabel("Eb/N0");
ylabel("BER");

ylim([1e-4 1e0])
xlim([EbN0dB(1) 25])

legend({'8PSK-LSKF-RICE', 'Theoretical error for 8PSK-RICE'})
grid on
hold off


nexttile
semilogy(EbN0dB, SISO_RICE_16PSK, 'Color', 'Red'); 
hold on
semilogy(EbN0dB, SISO_RAW_RICE_16PSK, 'Color', 'Blue')
xlabel("Eb/N0");
ylabel("BER");

ylim([1e-4 1e0])
xlim([EbN0dB(1) 25])

legend({'16PSK-LSKF-RICE', 'Theoretical error for 16PSK-RICE'})
grid on
hold off

nexttile
semilogy(EbN0dB, SISO_RICE_32PSK, 'Color', 'Red'); 
hold on
semilogy(EbN0dB, SISO_RAW_RICE_32PSK, 'Color', 'Blue')
xlabel("Eb/N0");
ylabel("BER");

ylim([1e-4 1e0])
xlim([EbN0dB(1) 35])

legend({'32PSK-LSKF-RICE', 'Theoretical error for 32PSK-RICE'})
grid on
hold off

nexttile
semilogy(EbN0dB, SISO_RICE_64PSK, 'Color', 'Red'); 
hold on
semilogy(EbN0dB, SISO_RAW_RICE_64PSK, 'Color', 'Blue')
xlabel("Eb/N0");
ylabel("BER");

ylim([6e-5 1e0])
xlim([EbN0dB(1) 35])

legend({'64PSK-LSKF-RICE', 'Theoretical error for 64PSK-RICE'})
grid on
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;

%% Full Plotting for Rayleigh channel
semilogy(EbN0dB, SISO_RAW_RAYL_64PSK, 'Color', 'black')
hold on 
semilogy(EbN0dB, SISO_RAYL_BPSK, 'Color', 'red')
semilogy(EbN0dB, SISO_RAYL_QPSK, 'Color', 'cyan')
semilogy(EbN0dB, SISO_RAYL_8PSK, 'Color', 'black')
semilogy(EbN0dB, SISO_RAYL_16PSK, 'Color', 'blue')
semilogy(EbN0dB, SISO_RAYL_32PSK, 'Color', 'green')
semilogy(EbN0dB, SISO_RAYL_64PSK, 'Color', 'yellow')
grid on

xlabel("Eb/N0");
ylabel("BER");
legend({'Theoretical error for 64PSK-Rayleigh','BPSK-LSKF-Rayleigh', 'QPSK-LSKF-Rayleigh', ...
    '8PSK-LSKF-Rayleigh', '32PSK-LSKF-Rayleigh', '32PSK-LSKF-Rayleigh', '64PSK-LSKF-Rayleigh'})


ylim([1e-4 1e0]);
xlim([EbN0dB(1) 35]);

title('Rayleigh Channels Comparative')
hold off

%% Full Plotting for Rayleigh channel
semilogy(EbN0dB, SISO_RAW_RICE_64PSK, 'Color', 'black')
hold on 
semilogy(EbN0dB, SISO_RICE_BPSK, 'Color', 'red')
semilogy(EbN0dB, SISO_RICE_QPSK, 'Color', 'cyan')
semilogy(EbN0dB, SISO_RICE_8PSK, 'Color', 'black')
semilogy(EbN0dB, SISO_RICE_16PSK, 'Color', 'blue')
semilogy(EbN0dB, SISO_RICE_32PSK, 'Color', 'green')
semilogy(EbN0dB, SISO_RICE_64PSK, 'Color', 'yellow')
grid on

xlabel("Eb/N0");
ylabel("BER");
legend({'Theoretical error for 64PSK-RICE','BPSK-LSKF-RICE', 'QPSK-LSKF-RICE', ...
    '8PSK-LSKF-RICE', '32PSK-LSKF-RICE', '32PSK-LSKF-RICE', '64PSK-LSKF-RICE'})


ylim([1e-4 1e0]);
xlim([EbN0dB(1) 35]);

title('Rician Channels Comparative')
hold off

