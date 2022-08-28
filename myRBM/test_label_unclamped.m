function energies = test_label_unclamped(M, cdk, b, c, v0, nhidden, breadth, cycles, T)      
    Nh = size(c, 1);
    Ni = size(b, 1);
    sigmoid = @(a) 1.0 ./ (1.0 + (exp(-a)/T)); % sigmoid activation function (where a = energy)
    energies = [Inf];

    % clamp training vector to random init image
    % v0 = rand(Ni,1);
    
    % positive phase: update hidden units
    p_h0v0 = sigmoid(M' * v0 + c); % forward: probability of hidden vector | data vector (0)
    h0 = p_h0v0 > rand(Nh,1); % stochastic

    vk = v0;
    hk = h0;

    % breadth control
    neuronsOff = randperm(nhidden, int16(nhidden*(1-breadth))); % random permutation of breadth % neurons to turn off
    neuronsOff = sort(neuronsOff); % order ascending

    nexttile
    imshow(reshape(v0(1:784), 28, 28)); % reshape test vector
    title(sprintf("Orig."))
    
    for i = 1:cycles % ruminative cycles
        % negative phase
        for k = 1:cdk % k-step cd_k (should / could this be Gibbs cycling?)
            energy = get_energy(vk, hk, M, b, c);
            % update visible units to get reconstruction
            p_vkhk = sigmoid(M * hk + b); % backward: probability of visible | hidden...why is this the opposite sign?
            vk = p_vkhk > rand(Ni, 1); % increased probabilistic, assumption: more stochastic recall - turn off for a more continous output
    
            % update hidden units again
            p_hkvk = sigmoid(M' * vk + c); % forward: probability of hidden | visible
            hk = p_hkvk > rand(Nh,1);

            for n = 1:length(neuronsOff)
                hk(neuronsOff(n)) = 0;
            end
            energies(end + 1) = sum(energy);
        end
        
        valPred = round(sum(vk(785:812))/length(vk(785:812)),4)*10; % predicted valence, rounded
        
        nexttile
        imshow(reshape(vk(1:784), 28, 28)); % reshape visible layer
        title(sprintf("b: %f, val.: %f", breadth, valPred))
    end
end