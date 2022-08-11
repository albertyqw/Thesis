function [h0, v0, vk, hk] = rbm_contrastive_divergence(M, b, c, cdk, x)
    Nh = size(c, 1);
    Ni = size(b, 1);
    sigmoid = @(a) 1.0 ./ (1.0 + exp(-a)); % sigmoid activation function (where a = energy)
    
    % clamp training vector to visible units
    v0 = x; % > rand(Ni,1);
    
    % positive phase: update hidden units
    p_h0v0 = sigmoid(M' * v0 + c); % forward: probability of hidden vector | data vector (0)
    h0 = p_h0v0 > rand(Nh,1); % stochastic

    vk = v0;
    hk = h0;
    % negative phase
    for k = 1:cdk % k-step CD
        % update visible units to get reconstruction
        p_vkhk = sigmoid(M * hk + b); % backward: probability of visible | hidden
        vk = p_vkhk; % > rand(Ni, 1); (keep probabilistic?)

        % update hidden units again
        p_hkvk = sigmoid(M' * vk + c); % forward: probability of hidden | visible
        hk = p_hkvk > rand(Nh,1);
    end
    
    % when computing gradient, we can use probabilities
    % for hidden units as well (beacuse Hinton says so)
    hk = p_hkvk;
    h0 = p_h0v0;
end