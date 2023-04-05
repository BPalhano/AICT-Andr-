function [graph] = lskf_ber(signal, bits, SNR_range, n, spec_error)
   
    % Incializo a quantidade atual de erros, o número de simbolos por
    % relização e um contador auxiliar;
    act_error = 0; 
    symbols = 2*n;
    counter = 1;

    % Inicializo um vetor para armazenar os erros obtidos;
    errors = zeros(size(SNR_range));
    
    % Para cada valor de SNR...
    for i = SNR_range
        

        % Equanto o contador de erros for menor que o número de erros a
        % serem contados...
        while act_error < spec_error
            
            % Adiciono ruido branco no sinal transmitido
            y = awgn(signal, i);
            
            % Estimo os vetores de símbolos
            [Bhat,Ahat] = norm_lskf(reshape(y, [n n]), 1);

            % Recomponho os vetores e aplico o decisor para BPSK:
            bits_hat = [Ahat' Bhat'];
            bits_hat = bpsk_decider(bits_hat, 0);
            
            % Armazeno a quantidade de erros e de símbolos transmitidos
            act_error = act_error + biterr(bits, bits_hat);
            symbols = symbols + 2*n;

        end

        % Redefino como zero o contador do laço
        act_error = 0;

        % Armazeno o para a SNR atual
        errors(counter) = spec_error / (spec_error + symbols);
        
        % Redefino como zero a quantidade de símbolos transmitidos
        symbols = 0;

        % Adiciono um ao contador auxiliar
        counter = counter + 1;
        
    end

    % Gero o plot usando a função semilogy, eixo X: Range da SNR
    % (padronizado entre -20 e 20 dB), eixo Y: Número de erros médio para
    % cada SNR.
    graph = semilogy(SNR_range, errors, 'Color', 'Red'); 
    xlabel("Eb/N0");
    ylabel("BER");
    title("Bit Error Rate x Eb/N0");

end

