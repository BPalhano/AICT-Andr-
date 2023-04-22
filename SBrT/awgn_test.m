clear;clc;close all;

% Range de SNR a ser percorrido
EbN0dBvtr = -10:0.5:15;
% SISO AWGN System

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
symb = 16; % n° de bits na transmissão
Mod_order = 2; % ordem da modulação
data = randi([0 Mod_order-1],symb, 1); % gero o vetor de bits
txSig_mod = pskmod(data, Mod_order); % uso a função de mod. psk

% Variáveis auxiliares
act_error = 0;  % n° de erros atual na potência de transmissão
symb_tot = symb; % n° de bits transmitidos
counter = 1; % contador auxiliar
spec_error = 1e2; % n° de erros esperados
errors = zeros(size(EbN0dBvtr)); % vetor de erros por potência de transmissão

% Função genérica para erro em modulação M-PSK.
general_Theoretical_error = @(range, M) 2*qfunc(sqrt(2*db2pow(range))*sin(pi/M));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tx1 = txSig_mod(1:symb/2,:); % vetor auxiliar
tx2 = txSig_mod(symb/2+1:end,:); % vetor auxiliar

txSig = kron(tx1, tx2); % símbolos de transmissão

for EbN0 = EbN0dBvtr

    while act_error < spec_error
            
        % Adiciono ruido branco no sinal transmitido
        sigma = 1 / (10^(EbN0/10));
        N = sqrt(sigma/2)*(randn(size(txSig)) + 1i*randn(size(txSig)));

        y = txSig + N;
            
        % Estimo os vetores de símbolos
        [rx2,rx1] = norm_lskf(reshape(y, [symb/2 symb/2]), tx1(1,1), tx2(1,1));

        % Recomponho os vetores e aplico o decisor para BPSK:
        rxSig_mod = [rx1' rx2'];
        rxSig_dmod = pskdemod(rxSig_mod, Mod_order);

        % Armazeno a quantidade de erros e de símbolos transmitidos
        act_error = act_error + biterr(data, (rxSig_dmod'));
        symb_tot = symb_tot + symb;
        
        disp(["Actual SNR: " EbN0 "número de erros: " num2str(act_error) "/" num2str(symb_tot)])
        

    end

    % Redefino como zero o contador do laço
    

    % Armazeno o erro para a SNR atual
    errors(counter) = act_error / (act_error + symb_tot);
    act_error = 0;
    % Redefino como zero a quantidade de símbolos transmitidos
    symb_tot = 0;

    % Adiciono um ao contador auxiliar
    counter = counter + 1;
        
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Plot do erro encontrado
semilogy(EbN0dBvtr, errors, 'Color', 'Red'); 
hold on
semilogy(EbN0dBvtr, general_Theoretical_error(EbN0dBvtr,Mod_order), 'Color', 'Blue')
grid on
hold off

xlabel("Eb/N0");
ylabel("BER");

title("Bit Error Rate x Eb/N0");
legend({'LSKF', 'Theoretical error'})

