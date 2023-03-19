clear;
clc;

% Gerando os vetores a serem recebidos:
bspk_array = [0 1];
qam_array = [complex(1,-1) complex(-1,-1) complex(-1,1) complex(1,1)];
N = 5000;
system_setup = zeros(N, 2); 
systotal = [];
SNR = -10:5:20;


for j = SNR
    for i = 1:N

        X1 = BSPK(bspk_array, 2); % Tensor rank 1 com os símbolos do BSPK;
        X2 = QAM(qam_array, 4); % Tensor rank 2 com os símbolos do 4-QAM
        X = khat(X1, X2); % Multiplexação dos símbolos de X1 e X2;
        B = rand(2,2); % Geração do sinal AWGN;
        actual_SNR = 10^(j/10);
        sigma = norm(X, "fro") /(actual_SNR*norm(B, "fro")); 
        
        Y = X + sigma*B; % Simulando sinal recebido na realização atual; 
        nmse = separation(Y,X1,X2);
    
        system_setup(i,1) = nmse(1);
        system_setup(i,2) = nmse(2);
    end
    systotal = [systotal ;(mean(system_setup))];
end

plot(SNR, systotal(:,1), 'r');
hold on
plot(SNR, systotal(:,2),'b');

xlabel('SNR[dB]')
ylabel('mean of MNSE')
legend('Erro relativo ao BSPK', 'Erro relativo ao 4QAM');
title('NMSE x SNR');
hold off


function x = khat(A,B)

    c = size(A,2);
    x = [];
    for i = 1:c

        d = kron(A(:,i), B(:,i));
        x = [x, d];
    end

end


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

function mnse = separation(Y,X1,X2)

    CX1 = X1(1,:);
    CX2 = X2(1,:);

    x1_hat = CX1;
    l2x2 = Y(2,:) ./ CX1(2);
    x2_hat = [CX2 ; l2x2];

    nmse1 = ((norm(X1 - x1_hat, "fro")) / (norm(X1, "fro")))^2;
    nmse2 = ((norm(X2 - x2_hat, "fro")) / (norm(X2, "fro")))^2;
    mnse = [nmse1, nmse2];


end