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