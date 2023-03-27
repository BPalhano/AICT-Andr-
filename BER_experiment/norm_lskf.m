function [A,B] = norm_lskf(tensor, norm)
    % This function estimate the signals A and B using a tensor.
    % You first have to reshape the tensor to ...
    [u,s,v] = svd(tensor);
    sig = s(1,1);
    
    A = u(:,1) * sqrt(sig);
    B = sqrt(sig) * conj(v(:,1));

    norm_A = norm / A(1,1);
    norm_B = norm / B(1,1);

    A = A * norm_A;
    B = B * norm_B;

end