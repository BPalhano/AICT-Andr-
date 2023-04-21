function [A,B] = norm_lskf(tensor, pA, pB)
    % Normalized Least-Squares Kronecker Factorization for matrix.
    % A kron B = vec(BA^T) = B o A
    % Â = u(:,1)*sqrt(sigma), ^B = v*(:,1)*sqrt(sigma); 
    %
    % Inputs:
    % tensor: Matrix rank-1 composed by B kron A
    % pA: already-know pilot signal of A (often the first element of A)
    % pB: already-know pilot signal of B (often the first element of B)
    %
    % Outputs:
    % A: estimated value of A
    % B: estimated value of B

    % Decomponho o tensor usando SVD
    [u,s,v] = svd(tensor);

    % Armazeno o valor singular mais significativo
    sig = s(1,1);
 
    % Estimo o vetor A
    A = u(:,1) * sqrt(sig);
    % Estimo o vetor B
    B = sqrt(sig) * conj(v(:,1));

    % Normalizo o vetor A
    norm_A = (pA) / A(1,1);
    A = A * norm_A;
    
    % Normalizo o vetor B
    norm_B = (pB) / B(1,1);
    B = B * norm_B;


end


