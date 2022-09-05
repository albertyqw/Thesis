function [errors, energies, imPred] = AR(M, cdk, b, c, x, label ...
    , state, nhidden, breadth, cycles, T, mood)      
    Nh = size(c, 1);
    Ni = size(b, 1);
    
    T = T+(0.02*mood); % adjust T by mood
    sigmoid = @(a) 1.0 ./ (1.0 + (exp(-a)/T)); % sigmoid activation function (where a = energy)

    energies = zeros(1, 288); % max cdk ("attention") / simple AR (240*1.1), makes all arrays equal
    errors = zeros(1, 288);
    energies(1) = [Inf];
    errors(1) = [Inf];
    
    % clamp training vector to test image
    v0 = x';
    
    % positive phase: update hidden units
    p_h0v0 = sigmoid(M' * v0 + c); % forward: probability of hidden vector | data vector (0)
    h0 = p_h0v0 > rand(Nh,1); % stochastic

    vk = v0;
    hk = h0;

    % breadth control
    neuronsOff = randperm(nhidden, int16(nhidden*(1-breadth)+mood)); % random permutation of % neurons to turn off - accounting for mood
    neuronsOff = sort(neuronsOff); % order ascending

    nexttile
    imshow(reshape(v0(1:784), 28, 28)); % reshape test vector
    title(sprintf("img %i", label)) % add valence label

    index = 0;
    % negative phase
    for i = 1:cycles
        for k = 1:cdk % k-step cd_k
            % update visible units to get reconstruction
            energy = get_energy(vk, hk, M, b, c);
            p_vkhk = sigmoid(M * hk + b); % backward: probability of visible | hidden
            vk = p_vkhk; % > rand(Ni, 1); % probabilistic
    
            % update hidden units again
            p_hkvk = sigmoid(M' * vk + c); % forward: probability of hidden | visible
            hk = p_hkvk > rand(Nh,1);
    
            for n = 1:length(neuronsOff)
                hk(neuronsOff(n)) = 0;
            end
            
            error = norm(x' - vk);
            
            index = index + 1;

            errors(index) = error;
            energies(index) = sum(energy);
        end
        
        imPred = sum(vk(785:812))/length(vk(785:812))*10; % predicted image / valence
    
        nexttile
        imshow(reshape(vk(1:784), 28, 28)); % reshape visible layer
        title(sprintf("im. pred.: %.2f \n mood: %.2f", imPred, mood))
    end
end