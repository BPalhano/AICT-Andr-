clear; close all; clc;

EbN0dBvtr = -5:0.5:15;
sigma_dB = 2;

symb = 16;
act_error = 0;
spec_error = 1e1;
symb_tot = symb;
counter = 1;

Modtx1 = 2;

errors = zeros(size(EbN0dBvtr));

tx1 = (binNpskmod(symb, Modtx1));
txSig = tx1;

%% BPSK
for EbN0dB = EbN0dBvtr
    

    SS = db2pow(randn()*sigma_dB); % This will change more slower than FF (slow-term fadding)
    sigma = 1/(10^(EbN0dB/10));
    N = sqrt(sigma/2)*(randn(size(txSig)) +1j*randn(size(txSig)));

    while act_error < spec_error

    FF = db2pow(ray_model(1)); % this will change for every sample (fast-term faddidng)

    rxSig = FF.*SS.*txSig + N;

    bTx1 = binNpskdemod(tx1,Modtx1);
    bRx1 = binNpskdemod(rxSig,Modtx1);

    Tx_demod = [bTx1];
    Rx_demod = [bRx1];

    act_error = act_error + biterr(Tx_demod, Rx_demod);

    symb_tot = symb_tot + symb;
    
    disp(["Actual SNR: " EbN0dB "número de erros: " num2str(act_error) "/" num2str(symb_tot) "actual BER: " act_error / (act_error + symb_tot)])
    
    end

errors(counter) = act_error / (act_error + symb_tot);
    
% Redefino como zero a quantidade de símbolos transmitidos
symb_tot = 0;
act_error = 0;

% Adiciono um ao contador auxiliar
counter = counter + 1;


end

semilogy(EbN0dBvtr, errors, 'black');
grid on
    

xlabel("Eb/N0, dB");
ylabel("BER");
ylim([1e-3 1e0])

%% QPSK