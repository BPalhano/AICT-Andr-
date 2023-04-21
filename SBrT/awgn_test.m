clear;
clc;
close all;

EbN0dB = -20:0.5:0;
% SISO AWGN System

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bits = 1e2;
Mod_order = 4;
data = randi([0 Mod_order-1],bits, 1);
txSig_tot = pskmod(data, Mod_order, pi/Mod_order);

act_error = 0; 
symbols = bits;
counter = 1;
spec_error = 1e6;
errors = zeros(size(EbN0dB));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tx1 = txSig_tot(1:bits/2,:);
tx2 = txSig_tot(bits/2+1:end,:);

txSig = kron(tx1, tx2);

for i = EbN0dB
    
    disp("Actual SNR:")
    disp(i)

    while act_error < spec_error
            
        % Adiciono ruido branco no sinal transmitido
        sigma = 1 / (10^(i/10));
        N = sqrt(sigma/2)*(randn(size(txSig)) + 1i*randn(size(txSig)));

        y = txSig + N;
            
        % Estimo os vetores de símbolos
        [rx2,rx1] = norm_lskf(reshape(y, [bits/2 bits/2]), tx1(1,1), tx2(1,1));

        % Recomponho os vetores e aplico o decisor para BPSK:
        rxSig = [rx1' rx2'];
        rxSig_tot = pskdemod(rxSig, Mod_order);

        % Armazeno a quantidade de erros e de símbolos transmitidos
        act_error = act_error + biterr(data, rxSig_tot');
        symbols = symbols + bits;
        
        % Condição de parada secundária (saturação

        
        disp("number of erros")
        disp(act_error)

    end

    % Redefino como zero o contador do laço
    

    % Armazeno o erro para a SNR atual
    errors(counter) = act_error / (act_error + symbols);
    act_error = 0;
    % Redefino como zero a quantidade de símbolos transmitidos
    symbols = 0;

    % Adiciono um ao contador auxiliar
    counter = counter + 1;
        
end

semilogy(EbN0dB, errors, 'Color', 'Red'); 
hold on
semilogy(EbN0dB, qfunc(sqrt(2*db2pow(EbN0dB))), 'Color', 'Blue')
hold off

xlabel("Eb/N0");
ylabel("BER");

title("Bit Error Rate x Eb/N0");
legend({'LSKF', 'Theoretical error'})



