function [errors, energies] = test_label_input(M, cdk, b, c, x, i, state, nhidden, breadth)      
    Nh = size(c, 1);
    Ni = size(b, 1);
    sigmoid = @(a) 1.0 ./ (1.0 + exp(-a)); % sigmoid activation function (where a = energy)
    energies = [Inf];
    errors = [Inf];
    
    % clamp training vector to test image
    v0 = x';
    
    % positive phase: update hidden units
    p_h0v0 = sigmoid(M' * v0 + c); % forward: probability of hidden vector | data vector (0)
    h0 = p_h0v0 > rand(Nh,1); % stochastic

    vk = v0;
    hk = h0;

    % breadth control
    neuronsOff = randperm(nhidden, int16(nhidden*(1-breadth))); % random permutation of breadth % neurons to turn off
    neuronsOff = sort(neuronsOff); % order ascending

    % negative phase
    for k = 1:cdk % k-step cd_k (should / could this be Gibbs cycling?)
        % update visible units to get reconstruction
        energy = get_energy(vk, hk, M, b, c); % are we collecting this at the right time?
        p_vkhk = sigmoid(M * hk + b); % backward: probability of visible | hidden
        vk = p_vkhk; % > rand(Ni, 1); % probabilistic

        % update hidden units again
        p_hkvk = sigmoid(M' * vk + c); % forward: probability of hidden | visible
        hk = p_hkvk > rand(Nh,1);

        for n = 1:length(neuronsOff)
            hk(neuronsOff(n)) = 0;
        end

        error = norm(x' - vk);
        errors(end + 1) = error;
        energies(end + 1) = sum(energy);
    end
    
    valPred = sum(vk(785:812))/length(vk(785:812));
    nexttile
    imshow(reshape(v0(1:784), 28, 28)); % reshape test vector
    title(sprintf("img %i", i))

    nexttile
    imshow(reshape(vk(1:784), 28, 28)); % reshape visible layer
    title(sprintf("pred. valence %f", valPred))
end