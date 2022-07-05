function [M, b, c] = rbm_init(ninput, nhidden)
    % weight matrix (good to start with small weights)
    M = 0.01 * (randn(ninput, nhidden) - 0.5);
    % biases (initalized zeros)
    c = zeros(nhidden,1);
    b = zeros(ninput,1);
end