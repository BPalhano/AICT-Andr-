function [Ahat,Bhat] = LSkronF(C,ia,ja,ib,jb, pA, pB)
    [ic,jc] = size(C);
    
    I = (ic/ia) + zeros(1,ia);
    J = (jc/ja) + zeros(1,ja);
    
    blocks_of_C = mat2cell(C,I,J);
    
    k = 1;
    
    Chat = complex(zeros(ib*jb,ia*ja),0);
    
    for j = 1:ja
        for i = 1:ia
            vec_of_block = cell2mat(blocks_of_C(i,j));
            vec_of_block = vec_of_block(:);
            Chat(:,k) = vec_of_block;
            
            k = k + 1;
        end
    end

    Chat = gpuArray(Chat);
    [U,S,V] = svd(Chat);
    
    U = gather(U);
    S = gather(S);
    V = gather(V);

    ahat = sqrt(S(1,1)).*conj(V(:,1));
    bhat = sqrt(S(1,1)).*U(:,1);

    ahat = ahat *(pA/ahat(1,1));
    bhat = bhat *(pB/bhat(1,1));
    
    Ahat = reshape(ahat,[ia ja]);
    Bhat = reshape(bhat, [ib jb]);
end