function [Y_est,Z_est] = kronfact(B,n,m,p,q)
%B is the received matrix having dimension np*mq
% n and m are the rows and columns of Y
% p and q are the rows and columns of Z
Btilde =  NaN(p * q ,n * m);
for ii = 1:m   %COLUMNS OF Y
    for jj = 1:n %ROWS OF Y
        
       Btilde(:,(ii-1)*n + jj) = reshape( B((jj-1)* p +1:jj* p , (ii-1)* q +1:ii* q ),[], 1);
        
    end    
    
end
[u, s, v] = svd(Btilde);

yest = sqrt(s(1,1))* conj(v(:,1));
Y_est = reshape(yest,[n,m]);

zest = sqrt(s(1,1))* u(:,1);
Z_est = reshape(zest,[p,q]);

B_est = kron(Y_est,Z_est);

end