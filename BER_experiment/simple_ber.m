close all;
clear;
clc;

% 
bits = 64;
EbN0dB = -20:0;
error = 0;

% Generating the information;
s = randi([0 1],1,bits);
x = BPSK_mapping(s);
 
% generating A and B;
n = bits/2;

% Slicing x:
A = x(:,1:n);
B = x(:,n+1:end);

% Generating C:
C = kron(A,B);

act_error = 0; 
symbols = 2*n;
counter = 1;
spec_error = 100;

% Inicializo um vetor para armazenar os erros obtidos;
errors = zeros(size(EbN0dB));
    
% Para cada valor de SNR...
for i = EbN0dB
        

    % Equanto o contador de erros for menor que o número de erros a
    % serem contados...
    disp("number of simulation")
    disp(i)
    while act_error < spec_error
            
        % Adiciono ruido branco no sinal transmitido
        sigma = 1 / (10^(i/10));
        N = sqrt(sigma/2)*(randn(size(C)) + 1i*randn(size(C)));

        y = C + N;
            
        % Estimo os vetores de símbolos
        [Bhat,Ahat] = norm_lskf(reshape(y, [n n]), 1);

        % Recomponho os vetores e aplico o decisor para BPSK:
        bits_hat = [Ahat' Bhat'];
        bits_hat = bpsk_decider(bits_hat, 0);
            
        % Armazeno a quantidade de erros e de símbolos transmitidos
        act_error = act_error + biterr(bpsk_demapping(x), bits_hat);
        symbols = symbols + 2*n;
        
        if symbols > 10e8
            break;
        end
        
        disp("number of erros")
        disp(act_error)

    end

    % Redefino como zero o contador do laço
    act_error = 0;

    % Armazeno o erro para a SNR atual
    errors(counter) = spec_error / (spec_error + symbols);
    % Redefino como zero a quantidade de símbolos transmitidos
    symbols = 0;

    % Adiciono um ao contador auxiliar
    counter = counter + 1;
        
end

% Gero o plot usando a função semilogy, eixo X: Range da SNR
% (padronizado entre -20 e 20 dB), eixo Y: Número de erros médio para
% cada SNR.


semilogy(EbN0dB, errors, 'Color', 'Red'); 
hold on
semilogy(-20:20, qfunc(sqrt(2*db2pow(-20:20))), 'Color', 'Blue')
hold off

xlabel("Eb/N0");
ylabel("BER");

title("Bit Error Rate x Eb/N0");
legend({'BER', 'Theoretical error'})

function [A,B] = norm_lskf(tensor, norm)
    
    % Decomponho o tensor usando SVD
    [u,s,v] = svd(tensor);

    % Armazeno o valor singular mais significativo
    sig = s(1,1);
 
    % Estimo o vetor A
    A = u(:,1) * sqrt(sig);
    % Estimo o vetor B
    B = sqrt(sig) * conj(v(:,1));

    % Normalizo o vetor A
    norm_A = norm / A(1,1);
    A = A * norm_A;
    
    % Normalizo o vetor B
    norm_B = norm / B(1,1);
    B = B * norm_B;


end





 