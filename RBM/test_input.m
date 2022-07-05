%% run with: test_input(M, 10, c, b, tsImages(i,:))
function inputActivation = test_input(M, cd_k, c, b, x)      
    Nh = size(c, 1);
    Ni = size(b, 1);
    sigmoid = @(a) 1.0 ./ (1.0 + exp(-a)); % sigmoid activation function (where a = energy)
    
    % clamp training vector to test image
    v0 = x';
    
    % positive phase: update hidden units
    p_h0v0 = sigmoid(M' * v0 + c); % forward: probability of hidden vector | data vector (0)
    h0 = p_h0v0 > rand(Nh,1); % stochastic

    vk = v0;
    hk = h0;
    % negative phase
    for k = 1:cd_k % k-step cd_k (should / could this be Gibbs cycling?)
        % update visible units to get reconstruction
        p_vkhk = sigmoid(M * hk + b); % backward: probability of visible | hidden
        vk = p_vkhk; % > rand(Ni, 1); (keep probabilistic?)

        % update hidden units again
        p_hkvk = sigmoid(M' * vk + c); % forward: probability of hidden | visible
        hk = p_hkvk > rand(Nh,1);
    end
    
    nexttile
    imshow(reshape(v0, 28, 28)); % reshape test vector
    title("Original Image")

    nexttile
    imshow(reshape(vk, 28, 28)); % reshape visible layer
    title("Reconstructed Image")
end