function [A_hat, B_hat] = generic_lskf(tensor, n,m,p,q)

% B is the received matrix having dimension np x mq
% n and m are the rows and columns of A
% p and q are the rows and columns of B

Btilde = NaN(p*q, n*m);

for ii = 1:m % Columns of A
    for jj = 1:n % Rows of A

        Btilde(:, (ii-1)*n + jj) = reshape(tensor((jj-1)* p + 1:jj*p, ...
            (ii-1) * q + 1:ii* q), [], 1);
    end
end

[u,s,v] = svd(Btilde);

a_hat = sqrt(s(1,1)) * conj(v(:,1));
A_hat = reshape(a_hat, [n,m]);

b_hat = sqrt(s(1,1)) * u(:,1);
B_hat = reshape(b_hat, [p,q]);

end

