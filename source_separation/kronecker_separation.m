% Limpeza do ambiente da IDE;
clear;
clc;

% Gerando os vetores a serem recebidos:
bspk_array = [0 1];
qam_array = [complex(1,-1) complex(-1,-1) complex(-1,1) complex(1,1)];
N = 5000;

% valor de X1 e X2 real e estimado e os 2 valores de NMSE geraos
system_setup = zeros(N, 2); 
systotal = [];
SNR = -10:5:20;

for j = SNR
    for i = 1:N

        X1 = BSPK(bspk_array, 2); % Tensor rank 1 com os símbolos do BSPK;
        X2 = QAM(qam_array, 4); % Tensor rank 2 com os símbolos do 4-QAM
        X = kron(X1, X2); % Multiplexação dos símbolos de X1 e X2;
        B = rand(2,4); % Geração do sinal AWGN;
        actual_SNR = 10^(j/10);
        sigma = norm(X, "fro") /(actual_SNR*norm(B, "fro")); 
        
        Y = X + sigma*B; % Simulando sinal recebido na realização atual; 
        nmse = separation(Y,X1,X2);
    
        system_setup(i,1) = nmse(1);
        system_setup(i,2) = nmse(2);
    end
    systotal = [systotal ;(mean(system_setup))];
end
% plotando os valores de MNSE:


plot(SNR, systotal(:,1), 'r');
hold on
plot(SNR, systotal(:,2),'b');

xlabel('SNR[dB]')
ylabel('mean of MNSE')
legend('Erro relativo ao BSPK', 'Erro relativo ao 4QAM');
title('NMSE x SNR');
hold off


function x =  BSPK(sample, n)

    
    for i = 1:n
        data = randsample(sample, 1);
        if data == 0
             data = -1;
        end
        x(i) = data;
    end
    
end

function x = QAM(sample, n)
    
    for i = 1:n
        x(i) = randsample(sample, 1);
    
    end

    x = reshape(x, [2 2]);
end

function nmse = separation(Y, X1, X2)
    
    % Função estima os sinais X1 e X2 a partir de Y e compara com a
    % estimação obtida a partir do X das mesmas componentes, calculando
    % assim o erro a partir da norma de Frobenius;
    %
    % input:
    % Y -> Sinal recebido na realização atual do sistema;
    % X -> Sinal gerado na multiplexação do sistema;
    % 
    % output:
    % nmse -> Erro relativo a partir da norma de Frobenius;

    a1 = X1(1,1); % é conhecido!
    b1 = X2(1,1); % é conhecido!

    c = size(Y,2); 
    a1vecX2 = Y(:,1:2);

    a1vecX2 = reshape(a1vecX2, [1 c]);
    vecX2 = a1vecX2 ./ a1;
    vecX2(1,1) = b1;

    a2 = mean(mean(Y(:,3:4) ./ reshape(vecX2, [2 2])));
    
    x1_hat = [a1, a2];
    x2_hat = reshape(vecX2, [2 2]);

    x1_hat = reshape(x1_hat, [1 2]);
    x2_hat = reshape(x2_hat, [2 2]);

    nmse1 = ((norm(X1 - x1_hat, "fro")) / (norm(X1, "fro")))^2;
    nmse2 = ((norm(X2 - x2_hat, "fro")) / (norm(X2, "fro")))^2;
    nmse = [nmse1, nmse2];


end