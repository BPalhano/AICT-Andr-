function [A,B] = norm_lskf(tensor, pA, pB)
    
    % Decomponho o tensor usando SVD
    [u,s,v] = svd(tensor);

    % Armazeno o valor singular mais significativo
    sig = s(1,1);
 
    % Estimo o vetor A
    A = u(:,1) * sqrt(sig);
    % Estimo o vetor B
    B = sqrt(sig) * conj(v(:,1));

    % Normalizo o vetor A
    norm_A = abs(pA) / A(1,1);
    A = A * norm_A;
    
    % Normalizo o vetor B
    norm_B = abs(pB) / B(1,1);
    B = B * norm_B;


end


