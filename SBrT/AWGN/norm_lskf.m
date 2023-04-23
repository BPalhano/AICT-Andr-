function [Ahat,Bhat] = norm_lskf(X, A, B)
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
    
    GPUtensor = gpuArray(X);
    [u,s,v] = svd(GPUtensor);
    
    u = gather(u);
    s = gather(s);
    v = gather(v);

    % Armazeno o valor singular mais significativo
    sig = s(1,1);
 
    % Estimo o vetor A
    Ahat = u(:,1) * sqrt(sig);
    % Estimo o vetor B
    Bhat = sqrt(sig) * conj(v(:,1));

    % Normalizo o vetor A
    norm_A = A(1,1) / Ahat(1,1);
    Ahat = Ahat .* norm_A;
    
    % Normalizo o vetor B
    norm_B = B(1,1) / Bhat(1,1);
    Bhat = Bhat .* norm_B;


end


