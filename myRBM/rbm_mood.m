function [M,b,c, errors, energies, tsPredY] = rbm_mood(epsilon, Ni, trImages, tsImages, trLabels, nhidden, max_epochs, cd_k)
    %% initialize RBM
    [M, b, c] = rbm_init(Ni, nhidden); % weights, biases
    
    %% train RBM
    % max_epochs = 5; % number of training epochs
    % epsilon = 0.001; % learning rate
    alpha = 0.5; % momentum - unused (though may be biologically relevant)
    lambda = 1e-5; % regularization - unused
    % cd_k = 2; % contrastive-divergence steps
    [M, b, c, errors, energies] = rbm_train(trImages, M, b, c, cd_k, epsilon, max_epochs);
    
    %% encoding digits
    trImgCodes = rbm_encode(trImages, M, b, c); % activate neurons, returns hidden neurons
    tsImgCodes = rbm_encode(tsImages, M, b, c);
    
    %% training softmax layer (to classify hidden unit activations) - learning valence
    softmax = trainSoftmaxLayer(trImgCodes', trLabels', 'MaxEpochs', 50); % MATLAB function
    trPredY = softmax(trImgCodes');
    tsPredY = softmax(tsImgCodes');
    
    %% error plot
    figure
    plot(1:size(errors, 2), errors);
    title(sprintf('Training Error'));
    % title(sprintf('training error,lambda: %f', lambda));
    xlabel('epoch');
    ylabel('error');

    %% energies plot
    figure
    plot(1:size(energies, 2), energies);
    title(sprintf('Training Energies'));
    % title(sprintf('training error,lambda: %f', lambda));
    xlabel('epoch');
    ylabel('energy');

    %% confusion matrices
    figure
    title('Training Confusion Matrix');
    plotconfusion(trLabels', trPredY, sprintf('TR set')); % - , alpha: %f lambda: %f', alpha, lambda));
    
    % test set
    % figure
    % title('confusion matrix TS');
    % plotconfusion(tsLabels', tsPredY, sprintf('TS set')); % - , alpha: %f lambda: %f', alpha, lambda));

    %% hidden unit weights
    figure
    hold on
    for i=1:nhidden
       subplot(12, 12, i);
       imshow(reshape(M(1:812,i), 28, 29));
       %title(sprintf('unit %d', i));
    end
    hold off
end