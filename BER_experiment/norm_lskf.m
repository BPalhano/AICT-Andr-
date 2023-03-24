function [A,B] = norm_lskf(tensor)
    % This function estimate the signals A and B using a tensor.
    % You first have to reshape the tensor to ...
    [u,s,v] = svd(tensor);
    sig = s(1,1);
    
    A = u(:,1) * sqrt(sig);
    B = sqrt(sig) * conj(v(:,1));

    norm_A = 1 / A(1,1);
    norm_B = 1 / B(1,1);

    A = A * norm_A;
    B = B * norm_B;

end