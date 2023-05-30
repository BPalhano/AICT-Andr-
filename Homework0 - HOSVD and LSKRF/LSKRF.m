function [Ahat,Bhat] = LSKRF(C,ia,ib)
    jc = size(C,2);
    
    Ahat = complex(zeros(ia,jc),0);
    Bhat = complex(zeros(ib,jc),0);
    
    for j = 1:jc
        Cp = C(:,j);
        Cp = reshape(Cp, [ib ia]);
        [U,S,V] = svd(Cp);
        Ahat(:,j) = sqrt(S(1,1)).*conj(V(:,1));
        Bhat(:,j) = sqrt(S(1,1)).*U(:,1);
    end
end