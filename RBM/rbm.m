%% load MNIST dataset (see RBM)
trImages = loadMNISTImages('./dataset/train-images.idx3-ubyte'); % training images
trLabels = loadMNISTLabels('./dataset/train-labels.idx1-ubyte'); % training labels
tsImages = loadMNISTImages('./dataset/t10k-images.idx3-ubyte'); % test images
tsLabels = loadMNISTLabels('./dataset/t10k-labels.idx1-ubyte'); % test labels

trImages = trImages'; % transposing images
tsImages = tsImages';

trLabels = one_hot(trLabels, 10); % one hot encoding (by class i.e. 1:10)
tsLabels = one_hot(tsLabels, 10);

Nd = size(trImages, 1); % num vectors
Ni = size(trImages, 2); % num inputs

%% initialize RBM
nhidden = 100; % number of hidden units
[M, b, c] = rbm_init(Ni, nhidden); % weights, biases

%% train RBM
max_epochs = 4; % number of training epochs
epsilon = 0.001; % learning rate
alpha = 0.5; % momentum - unused
lambda = 1e-5; % regularization - unused
k = 1; % contrastive-divergence steps
[M, b, c, errors] = rbm_train(trImages, M, b, c, k, epsilon, alpha, lambda, max_epochs);

%% encoding digits
% trImgCodes = rbm_encode(trImages, M, b, c); % activate neurons, returns hidden neurons
% tsImgCodes = rbm_encode(tsImages, M, b, c);

%% training softmax layer (to classify hidden unit activations)
% softmax = trainSoftmaxLayer(trImgCodes', trLabels', 'MaxEpochs', 1000); % MATLAB function
% trPredY = softmax(trImgCodes');
% tsPredY = softmax(tsImgCodes');

%% error plot
figure
plot(1:size(errors, 2), errors);
title(sprintf('training error, alpha: %f lambda: %f', alpha, lambda));
xlabel('epoch');
ylabel('error');

%% confusion matrices
% figure
% title('confusion matrix TR');
% plotconfusion(trLabels', trPredY, sprintf('TR set - , alpha: %f lambda: %f', alpha, lambda));

% figure
% title('confusion matrix TS');
% plotconfusion(tsLabels', tsPredY, sprintf('TS set - , alpha: %f lambda: %f', alpha, lambda));

%% hidden unit weights
figure
hold on
for i=1:nhidden
   subplot(10, 10, i);
   imshow(reshape(M(:,i), 28, 28));
   %title(sprintf('unit %d', i));
end