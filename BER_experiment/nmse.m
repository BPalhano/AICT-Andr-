function [graph] = nmse(tensor_hat, tensor)
    
    N = size(tensor_hat,1);
    NMSE = zeros(N,1);

    for i = 1:N
        
        ((norm((double(tensor) - tensor_hat(2,:)), "fro")) / ...
            (norm(double(tensor), "fro"))^(2));
    end

    graph = plot(-20:20,NMSE, "Marker","diamond");

end

