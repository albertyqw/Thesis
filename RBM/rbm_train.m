function [M , b, c , errors] = rbm_train(X, M, b, c, cd_k, epsilon, alpha, lambda, max_epochs)
    %% initializing variables
    e = 0; % ~index variable (epochs)
    errors = [Inf]; % = infinite

    Nh = size(c, 1); % num hidden
    Ni = size(b, 1); % num input
    Nd = size(X, 1); % num data vectors (?)

    %% epochs
    while true
        deltaM = zeros(Ni, Nh);
        deltab = zeros(Ni, 1);
        deltac = zeros(Nh ,1);
        error = 0;
        
        % shuffle inputs
        fprintf('-- shuffling inputs\n');
        X = X(randperm(size(X, 1)),:);
        
        % stochastic updates
        fprintf('-- training...\n');
        for i = 1:Nd
            % k-step (cd_k) contrastive divergence
            [h0, v0, vk, hk] = rbm_contrastive_divergence(M, b, c, cd_k, X(i,:)');
            
            % compute gradient
            [Mgrad, bgrad, cgrad] = rbm_gradient(v0, h0, vk, hk);
            
            % momentum
            % adjusts learning rate to approximate a "rolling ball",
            % adjusting velocity
            % deltaM = alpha * deltaM + (1-alpha) * Mgrad;
            % deltab = alpha * deltab + (1-alpha) * bgrad;
            % deltac = alpha * deltac + (1-alpha) * cgrad;
            
            deltaM = Mgrad;
            deltab = bgrad;
            deltac = cgrad;

            % weights update, with learning rate
            M = M + epsilon * deltaM;
            b = b + epsilon * deltab;
            c = c + epsilon * deltac;

            % weight decay (penalizes large weighs to prevent overfitting)
            % M = M - lambda * M;
            
            % error metric
            error = error + norm(X(i,:)' - vk);
        end
        
        % mean error over tr samples
        errors(end + 1) = error / Nd; 

        fprintf('- epoch %d, error: %f\n', e, errors(end));
        if e > max_epochs
            break
        end
        
        e = e + 1;
    end
end
