function energies = FR(M, cdk, b, c, v0, nhidden, breadth, cycles, T, mood)      
    Nh = size(c, 1);
    Ni = size(b, 1);

    T = T+(0.02*mood); % adjust T by mood
    sigmoid = @(a) 1.0 ./ (1.0 + (exp(-a)/T)); % sigmoid activation function (where a = energy)
    energies = zeros(1,120); % rough maximum
    energies(1) = [Inf];

    % clamp training vector to random init image
    % v0 = rand(Ni,1);
    
    % positive phase: update hidden units
    p_h0v0 = sigmoid(M' * v0 + c); % forward: probability of hidden vector | data vector (0)
    h0 = p_h0v0 > rand(Nh,1); % stochastic

    vk = v0;
    hk = h0;
    mood = [mood];

    nexttile
    imshow(reshape(v0, 28, 29)); % reshape test vector
    title(sprintf("Orig. mood = %i", mood(end)))

    index = 0;
    
    for i = 1:cycles % ruminative cycles
        % breadth control
        neuronsOff = randperm(nhidden, int16(nhidden*(1-breadth)-mood(end))); % random permutation of breadth % neurons to turn off
        neuronsOff = sort(neuronsOff); % order ascending

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

            index = index + 1;
            energies(index) = sum(energy);
        end
        
        imPred = sum(vk(785:812))/length(vk(785:812))*10; % predicted image
        valPred = 2*(imPred-4.5); % predicted valence (still scaled [-9,9])

        mood(end+1) = 0.4*mood(end) + 0.6 *valPred; % 40% prior mood + 60% predicted valence
        cdk = mood_bias(mood(end), valPred, cdk); % can stack continuously here
        
        nexttile
        imshow(reshape(vk, 28, 29)); % reshape visible layer
        title(sprintf("im. pred.: %.2f \n mood: %.2f", imPred, mood(end)));
    end
end