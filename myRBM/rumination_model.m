% rumination model
%% pre-processing

loadData % load / prep MNIST dataset

nhidden = 144; % see Hinton's recipe
epsilon = 0.005; % meets Hinton's guidelines, seems to be an okay value for our learning
maxEpochs = 6; % 6 doesn't completely settle, but we don't want to overfit
cdk = 1; % contrastive-divergence steps for training

v0 = rand(Ni+28,1); % pure noisy input for rumination, with an extra row for valence label

trValences = [];
tsValences = [];

% store labels and scale
for a = 1:size(trLabels, 1)
    for b = 1:size(trLabels, 2)
        if trLabels(a,b) == 1
            trValences = [trValences;(b-1)/10]; % currently, valence = number, scaled to [0,0.9]
            break
        end
    end
end

for c = 1:size(tsLabels, 1)
    for d = 1:size(tsLabels, 2)
        if tsLabels(c,d) == 1
            tsValences = [tsValences;(d-1)/10];
            break
        end
    end
end

% create a column of valence labels
trLabelRow = repmat(trValences, 1, 28); % add 28x1 valence "label" to each row (image)
tsLabelRow = repmat(tsValences, 1, 28);

% add valence columns to images
trImagesL = [trImages, trLabelRow];
tsImagesL = [tsImages, tsLabelRow]; 

%% train

% train base RBM
[M_c, b_c, c_c, errors_c, energies_c, tsPredY] = rbm_mood(epsilon, Ni+28, trImagesL, tsImagesL, trLabels, nhidden, maxEpochs, cdk); % Ni + 28 for labels 

% equalize training between experimental and control
M_e = M_c;
b_e = b_c;
c_e = c_c;
errors_e = errors_c;

est_tsValences = amygdala(tsPredY); % getting weighted learned valences

% heatmap of learned weights
figure
title("Weights Heatmap")
heatmap(M_c);

%% recall tests
independentAR
dysphoricAR
freerecall
distractionAR
distractionFR