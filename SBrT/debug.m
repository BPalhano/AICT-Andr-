clear; close all; clc;

% Range de SNR a ser percorrido
EbN0dBvtr = -10:0.5:15;
% SISO AWGN System

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 16 símbolos para B e QPSK
symb = 4; % n° de símbolos na transmissão

Modtx1 = 2;
Modtx2 = 4;
Modtx3 = 8;
Modtx4 = 16;
Mod_order = 16;

% Variáveis auxiliares
act_error = 0;  % n° de erros atual na potência de transmissão
symb_tot = symb; % n° de bits transmitidos
counter = 1; % contador auxiliar
spec_error = 1e2; % n° de erros esperados
errors = zeros(size(EbN0dBvtr)); % vetor de erros por potência de transmissão

% Função genérica para erro em modulação M-PSK.
general_Theoretical_error = @(range, M) 2*qfunc(sqrt(2*db2pow(range))*sin(pi/M));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
spec = true;
plot = true;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%% Tensorial Modeling  %%%%%%%%%


% Para transmitir 16PSK:
for i = 1:1
tx1 = (binNpskmod(symb/2, Modtx1));
tx2 = (binNpskmod(symb/2, Modtx2));
tx3 = (binNpskmod(symb/2, Modtx3));
tx4 = (binNpskmod(symb/2, Modtx4));

tx1ktx2 = kron(tx1, tx2);
tx3ktx4 = kron(tx3, tx4);

txSig = kron(tx1ktx2, tx3ktx4);

%[rx3krx4, rx1krx2] = norm_lskf(reshape(txSig, [(symb/2)^2 (symb/2)^2]), tx1ktx2,tx3ktx4);
%[rx2, rx1] = norm_lskf(reshape(rx1krx2, [symb/2 symb/2]), tx1,tx2);
%[rx4, rx3] = norm_lskf(reshape(rx3krx4, [symb/2 symb/2]), tx3,tx4);

%rot = exp(1j*pi);

%rx1 = rot*rx1;
%rx2 = rot*rx2;
%rx3 = rot*rx3;
%rx4 = rot*rx4;



disp(["counter:" i]);


end



if spec
    for EbN0 = EbN0dBvtr
        while act_error < spec_error
        
        sigma = 1/10^(EbN0/10);
         N = sqrt(sigma/2)*(randn(size(txSig)) + 1i*randn(size(txSig)));
        
        y = txSig + N;

        %% QPSK
        % Para transmitir QPSK:
        % tx1 = binNpskmod(symb/2, Modtx1);
        % tx2 = binNpskmod(symb/2, Modtx2);

        % txSig = kron(tx1, tx2);

        %[rx1,rx2] = LSkronF(y,size(tx1,1),size(tx1,2),size(tx2,1), ...
        %    size(tx2,2), tx1(1,1), tx2(1,1));
        %
        %btx1 = binNpskdemod(tx1,Modtx1);
        %btx2 = binNpskdemod(tx2,Modtx2);
        %
        %brx1 = binNpskdemod(rx1,Modtx1);
        %brx2 = binNpskdemod(rx2,Modtx2);
        %
        %tx_demod = [btx1' btx2'];
        %rx_demod = [brx1' brx2'];
        %
        %act_error = act_error +biterr(tx_demod, rx_demod);
        %symb_tot = symb_tot + symb;

        %% 8PSK
        %[rx1krx2, rx3] = norm_lskf(reshape(y, [(symb/2)^2 symb/2]), tx1ktx2,tx3);
        %[rx1, rx2] = norm_lskf(reshape(rx1krx2, [symb/2 symb/2]), tx1,tx2);
        %
        %bTx1 = binNpskdemod(tx1,Modtx1);
        %bTx2 = binNpskdemod(tx2,Modtx2);
        %bTx3 = binNpskdemod(tx3, Modtx3);
        %
        %bRx1 = binNpskdemod(rx1,Modtx1);
        %bRx2 = binNpskdemod(rx2,Modtx2);
        %bRx3 = binNpskdemod(rx3, Modtx3);
        %
        %Tx_demod = [bTx1' bTx2' bTx3'];
        %Rx_demod = [bRx1' bRx2' bRx3'];
        %
        %act_error = act_error + biterr(Tx_demod, Rx_demod);
        %symb_tot = symb_tot + symb;
        
        %% 16PSK
        
        [rx1krx2, rx3krx4] = LSkronF(y, size(tx1ktx2,1), size(tx1ktx2,2), ...
                        size(tx3ktx4,1),size(tx3ktx4,2), tx1ktx2(1,1), tx3ktx4(1,1));

        [rx1, rx2] = LSkronF(rx1krx2, size(tx1,1), size(tx1,2), size(tx2,1), size(tx2,2), ...
                                            tx1(1,1), tx2(1,1));
        [rx3, rx4] = LSkronF(rx3krx4, size(tx3,1), size(tx3,2), size(tx4,1), size(tx4,2), ...
                                            tx3(1,1), tx4(1,1));


        bTx1 = binNpskdemod(tx1,Modtx1);
        bTx2 = binNpskdemod(tx2,Modtx2);
        bTx3 = binNpskdemod(tx3, Modtx3);
        bTx4 = binNpskdemod(tx4, Modtx4);

        bRx1 = binNpskdemod(rx1,Modtx1);
        bRx2 = binNpskdemod(rx2,Modtx2);
        bRx3 = binNpskdemod(rx3, Modtx3);
        bRx4 = binNpskdemod(rx4, Modtx4);

        Tx_demod = [bTx1' bTx2' bTx3' bTx4'];
        Rx_demod = [bRx1' bRx2' bRx3' bRx4'];

        act_error = act_error + biterr(Tx_demod, Rx_demod);
        symb_tot = symb_tot + symb;

        disp(["Actual SNR: " EbN0 "número de erros: " num2str(act_error) "/" num2str(symb_tot)])
        end

    % Armazeno o erro para a SNR atual
    errors(counter) = act_error / (act_error + symb_tot);
    
    % Redefino como zero a quantidade de símbolos transmitidos
    symb_tot = 0;
    act_error = 0;

    % Adiciono um ao contador auxiliar
    counter = counter + 1;

    end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Plot do erro encontrado
if plot
    semilogy(EbN0dBvtr, errors, 'Color', 'Red'); 
    hold on
    semilogy(EbN0dBvtr, general_Theoretical_error(EbN0dBvtr,Mod_order), 'Color', 'Blue')
    grid on
    hold off

    xlabel("Eb/N0");
    ylabel("BER");

    title("Bit Error Rate x Eb/N0");
    legend({'LSKF', 'Theoretical error'})
end
