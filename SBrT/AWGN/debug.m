clear; close all; clc;

% Range de SNR a ser percorrido
EbN0dBvtr = -10:0.5:15;
% SISO AWGN System

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 16 símbolos para B e QPSK
symbPvtr= 2; % n° de símbolos na transmissão por vetor

Modtx1 = 2;
Modtx2 = 4; 
Modtx3 = 8;
Modtx4 = 16;
Modtx5 = 32;
Modtx6 = 64;
Mod_order = 64;

% Variáveis auxiliares
act_error = 0;  % n° de erros atual na potência de transmissão
symb_tot = 6*symbPvtr; % n° de SÍMBOLOS transmitidos (3*symbPvtr p 8psk e 4*symbPvttr p 16psk
counter = 1; % contador auxiliar
spec_error = 1e2; % n° de erros esperados
errors = zeros(size(EbN0dBvtr)); % vetor de erros por potência de transmissão

% Função genérica para erro em modulação M-PSK.
general_Theoretical_error = @(range, M) 2*qfunc(sqrt(2*db2pow(range))*sin(pi/M));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
spec = true;
plot = false;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%% Tensorial Modeling  %%%%%%%%%
%tx1 = (binNpskmod(symbPvtr, Modtx1));
%tx2 = (binNpskmod(symbPvtr, Modtx2));
%tx3 = (binNpskmod(symbPvtr, Modtx3));
%tx4 = (binNpskmod(symbPvtr, Modtx4));
%tx5 = (binNpskmod(symbPvtr, Modtx5));

tx1 = [1 exp(1j*pi)];
tx2 = [1 exp(1j*(pi+pi/2))];
tx3 = [1 exp(1j*(pi+pi/4))];
tx4 = [1 exp(1j*(pi+pi/8))];
tx5 = [1 exp(1j*(pi+pi/16))];
tx6 = [1 exp(1j*(pi+pi/32))];


tx1ktx2 = kron(tx1, tx2); % QPSK
tx3ktx4 = kron(tx3, tx4); % 8PSK
tx1ktx2ktx3ktx4 = kron(tx1ktx2,tx3ktx4); % 16PSK
tx5ktx6 = kron(tx5, tx6);

txSig = kron(tx1ktx2ktx3ktx4, tx5ktx6);
% Para transmitir 16PSK:
for i = 1:1

end



if spec
    for EbN0 = EbN0dBvtr
        while act_error < spec_error
        
        sigma = 1/10^(EbN0/10);
         N = sqrt(sigma/2)*(randn(size(txSig)) + 1i*randn(size(txSig)));
        
        y = txSig + N;

        %% QPSK
        % Para transmitir QPSK:
        % tx1 = binNpskmod(symbPvtr, Modtx1);
        % tx2 = binNpskmod(symbPvtr, Modtx2);

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
        %symb_tot = symb_tot + 3*symbPvtr;

        %% 8PSK
        %
        %[rx1krx2, rx3] = norm_lskf(reshape(y, [(symbPvtr)^2 symbPvtr]), tx1ktx2,tx3);
        %[rx1, rx2] = norm_lskf(reshape(rx1krx2, [symbPvtr symbPvtr]), tx1,tx2);
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
        %symb_tot = symb_tot + 3*symbPvtr;
        
        %% 16PSK
        %tx1 = (binNpskmodsymbPvtr, Modtx1));
        %tx2 = (binNpskmod(symbPvtr, Modtx2));
        %tx3 = (binNpskmod(symbPvtr, Modtx3));
        %tx4 = (binNpskmod(symbPvtr, Modtx4));
        %
        %tx1ktx2 = kron(tx1, tx2);
        %tx3ktx4 = kron(tx3, tx4);
        %
        %txSig = kron(tx1ktx2, tx3ktx4);
        %
        %[rx1krx2, rx3krx4] = LSkronF(y, size(tx1ktx2,1), size(tx1ktx2,2), ...
        %                size(tx3ktx4,1),size(tx3ktx4,2), tx1ktx2(1,1), tx3ktx4(1,1));
        %
        %[rx1, rx2] = LSkronF(rx1krx2, size(tx1,1), size(tx1,2), size(tx2,1), size(tx2,2), ...
        %                                    tx1(1,1), tx2(1,1));
        %[rx3, rx4] = LSkronF(rx3krx4, size(tx3,1), size(tx3,2), size(tx4,1), size(tx4,2), ...
        %                                   tx3(1,1), tx4(1,1));
        % 
        % 
        %bTx1 = binNpskdemod(tx1,Modtx1);
        %bTx2 = binNpskdemod(tx2,Modtx2);
        %bTx3 = binNpskdemod(tx3, Modtx3);
        %bTx4 = binNpskdemod(tx4, Modtx4);
        %
        %bRx1 = binNpskdemod(rx1,Modtx1);
        %bRx2 = binNpskdemod(rx2,Modtx2);
        %bRx3 = binNpskdemod(rx3, Modtx3);
        %bRx4 = binNpskdemod(rx4, Modtx4);
        %
        %Tx_demod = [bTx1' bTx2' bTx3' bTx4'];
        %Rx_demod = [bRx1' bRx2' bRx3' bRx4'];
        %
        %act_error = act_error + biterr(Tx_demod, Rx_demod);
        %symb_tot = symb_tot + 4*symbPvtr;
        %
        
        %% 32PSK
        %[rx1krx2krx3, rx4krx5] = LSkronF(y, size(tx1ktx2ktx3,1), size(tx1ktx2ktx3,2), ...
        %                        size(tx4ktx5,1), size(tx4ktx5,2),tx1ktx2ktx3(1,1), tx4ktx5(1,1));
        %    
        %[rx1krx2, rx3] = norm_lskf(reshape(rx1krx2krx3, [(symbPvtr)^2 symbPvtr]), tx1ktx2,tx3);
        %
        %[rx1, rx2] = norm_lskf(reshape(rx1krx2, [symbPvtr symbPvtr]), tx1,tx2);
        %
        %[rx4, rx5] = LSkronF(rx4krx5, size(tx4,1), size(tx4,2), size(tx5,1), size(tx5,2), ...
        %                              tx4(1,1), tx5(1,1));
        %bTx1 = binNpskdemod(tx1,Modtx1);
        %bTx2 = binNpskdemod(tx2,Modtx2);
        %bTx3 = binNpskdemod(tx3, Modtx3);
        %bTx4 = binNpskdemod(tx4, Modtx4);
        %bTx5 = binNpskdemod(tx5, Modtx5);
        %
        %bRx1 = binNpskdemod(rx1,Modtx1);
        %bRx2 = binNpskdemod(rx2,Modtx2);
        %bRx3 = binNpskdemod(rx3, Modtx3);
        %bRx4 = binNpskdemod(rx4', Modtx4);
        %bRx5 = binNpskdemod(rx5', Modtx5);
        %
        %Tx_demod = [bTx1 bTx2 bTx3 bTx4 bTx5];
        %Rx_demod = [bRx1' bRx2' bRx3' bRx4' bRx5'];
        %
        %act_error = act_error + biterr(Tx_demod, Rx_demod);
        %symb_tot = symb_tot + 5*symbPvtr;
        
        %% 64PSK
        [rx1krx2krx3krx4, rx5krx6] = LSkronF(y, size(tx1ktx2ktx3ktx4,1), size(tx1ktx2ktx3ktx4,2), ...
                size(tx5ktx6,1),size(tx5ktx6,2), tx1ktx2ktx3ktx4(1,1), tx5ktx6(1,1));


        [rx1krx2, rx3krx4] = LSkronF(rx1krx2krx3krx4, size(tx1ktx2,1), size(tx1ktx2,2), ...
                size(tx3ktx4,1),size(tx3ktx4,2), tx1ktx2(1,1), tx3ktx4(1,1));

        [rx1, rx2] = LSkronF(rx1krx2, size(tx1,1), size(tx1,2), size(tx2,1), size(tx2,2), ...
                                    tx1(1,1), tx2(1,1));
        [rx3, rx4] = LSkronF(rx3krx4, size(tx3,1), size(tx3,2), size(tx4,1), size(tx4,2), ...
                                   tx3(1,1), tx4(1,1));

        [rx5, rx6] = LSkronF(rx5krx6, size(tx5,1), size(tx5,2), size(tx6,1), size(tx6,2), ...
                              tx5(1,1), tx6(1,1));

        bTx1 = binNpskdemod(tx1,Modtx1);
        bTx2 = binNpskdemod(tx2,Modtx2);
        bTx3 = binNpskdemod(tx3, Modtx3);
        bTx4 = binNpskdemod(tx4, Modtx4);
        bTx5 = binNpskdemod(tx5, Modtx5);
        bTx6 = binNpskdemod(tx6, Modtx6);

        bRx1 = binNpskdemod(rx1,Modtx1);
        bRx2 = binNpskdemod(rx2,Modtx2);
        bRx3 = binNpskdemod(rx3, Modtx3);
        bRx4 = binNpskdemod(rx4', Modtx4);
        bRx5 = binNpskdemod(rx5', Modtx5);
        bRx6 = binNpskdemod(rx6', Modtx6);

        Tx_demod = [bTx1  bTx2  bTx3  bTx4  bTx5  bTx6 ];
        Rx_demod = [bRx1 bRx2 bRx3 bRx4' bRx5' bRx6'];

        act_error = act_error + biterr(Tx_demod, Rx_demod);
        symb_tot = symb_tot + 6*symbPvtr;
        
        disp(["Actual SNR: " EbN0 "número de erros: " num2str(act_error) "/" num2str(symb_tot) "actual BER: " act_error / (act_error + symb_tot)])

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
