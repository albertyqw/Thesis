function [M, b, c, errors, energies] = rbm(epsilon, Ni, trImages, nhidden, maxEpochs, cdk)
    %% initialize RBM
    [M, b, c] = rbm_init(Ni, nhidden); % weights, biases
    
    %% train RBM
    % max_epochs = 5; % number of training epochs
    % epsilon = 0.001; % learning rate
    alpha = 0.5; % momentum - unused - probably will not use!
    lambda = 1e-5; % regularization - unused, decays older weights - could use in training for "old/irrelevant" memories
    % cd_k = 2; % contrastive-divergence steps
    [M, b, c, errors, energies] = rbm_train(trImages, M, b, c, cdk, epsilon, maxEpochs);
    
    %% encoding digits - amygdala valence
    trImgCodes = rbm_encode(trImages, M, b, c); % activate neurons, returns hidden neurons
    tsImgCodes = rbm_encode(tsImages, M, b, c);
    
    %% training softmax layer (to classify hidden unit activations)
    softmax = trainSoftmaxLayer(trImgCodes', trLabels', 'MaxEpochs', 1000); % MATLAB function
    trPredY = softmax(trImgCodes');
    tsPredY = softmax(tsImgCodes');
    
    %% error plot
    figure
    plot(1:size(errors, 2), errors);
    title(sprintf('Training error'));
    % title(sprintf('training error,lambda: %f', lambda));
    xlabel('epoch');
    ylabel('error');

    %% energies plot
    figure
    plot(1:size(energies, 2), energies);
    title(sprintf('Energies'));
    % title(sprintf('training error,lambda: %f', lambda));
    xlabel('epoch');
    ylabel('energy');
    %% confusion matrices
    % figure
    % title('confusion matrix TR');
    % plotconfusion(trLabels', trPredY, sprintf('TR set - , alpha: %f lambda: %f', alpha, lambda));
    
    % figure
    % title('confusion matrix TS');
    % plotconfusion(tsLabels', tsPredY, sprintf('TS set - , alpha: %f lambda: %f', alpha, lambda));

    %% hidden unit weights
    figure
    title(sprintf("Hidden unit weights"))
    hold on
    for i=1:nhidden
       subplot(10, 10, i);
       imshow(reshape(M(:,i), 28, 28));
    end
    hold off
    
end