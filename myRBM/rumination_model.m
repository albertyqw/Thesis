%% rumination model
loadData

nhidden = 144; % up from 100 % number of hidden units - modulate - see Hinton's recipe
epsilon = 0.005; % meets Hinton's guidelines, seems to be an okay value for our learning
maxEpochs = 6; % 8; for long % number of training epochs, 6 doesn't completely settle - but learning isn't perfect
cdk = 1; % contrastive-divergence steps

v0 = rand(Ni+28,1); % pure noisy input for rumination, with an extra row

trValence = [];
tsValence = [];
% get row and scale
for a = 1:size(trLabels, 1)
    for b = 1:size(trLabels, 2)
        if trLabels(a,b) == 1
            trValence = [trValence;(b-1)/10]; % currently, valence = number, scaled
            break
        end
    end
end
for c = 1:size(tsLabels, 1)
    for d = 1:size(tsLabels, 2)
        if tsLabels(c,d) == 1
            tsValence = [tsValence;(d-1)/10];
            break
        end
    end
end

% create a column of labels with valence
trValence = repmat(trValence, 1, 28); % add 28x1 to each row
tsValence = repmat(tsValence, 1, 28);

trImagesL = [trImages, trValence];
tsImagesL = [tsImages, tsValence]; 

% train
[M_c, b_c, c_c, errors_c, energies_c, tsPredY] = rbm_mood(epsilon, Ni+28, trImagesL, tsImagesL, trLabels, nhidden, maxEpochs, cdk); % Ni + 28 for labels 
M_e = M_c; % equalize training
b_e = b_c;
c_e = c_c;
errors_e = errors_c;
valences = amygdala(tsPredY); % setting valences

% weight heatmap
figure
title("weights heatmap")
heatmap(M_c);
%% recall tests

cBreadth = 0.90; % 0.99 % of neurons kept on for the control case
eBreadth = 0.80; % 0.90 """ for the experimental (trait rumination case)
acdk = 240; % associative recall k-steps
rcdk = 40; % rumination k-step
rCycles = 6; % number of ruminative "cycles" (giving us 4*30=120 total k-steps)

ts = [4,3,2,19,5,9,12,18,62,8];
ts54 = [5,7,20,25,28,34,19,31,33,45,52,64];

mood = 0;

pred_error_c = [];
pred_error_e = [];

T_e = 0.9;
T_c = 1.1;

figure
for i = 1:length(ts54) % subbing ts54
    mood = (mood + valences(ts54(i)))/i; % mood
    [errors_cAR, energies_cAR, val_pred_c] = test_label_input(M_c, acdk, b_c, c_c, tsImagesL(ts54(i),:), i, ...
        "ctl.", nhidden, cBreadth, T_c, mood); % mood adjusted
    [errors_eAR, energies_eAR, val_pred_e] = test_label_input(M_e, acdk, b_e, c_e, tsImagesL(ts54(i),:), i, ...
        "exp.", nhidden, eBreadth, T_e, mood);
    pred_error_c(end+1) = val_pred_c;
    pred_error_e(end+1) = val_pred_e;
end

ave_pred_error_c = (sum(abs([0:9]-pred_error_c)))/10;
ave_pred_error_e = (sum(abs([0:9]-pred_error_e)))/10;

% free recall - need to add mood effects
figure
energies_cFR = test_label_unclamped(M_c, rcdk, b_c, c_c, v0, nhidden, cBreadth, rCycles, T_c);
energies_eFR = test_label_unclamped(M_e, rcdk, b_e, c_e, v0, nhidden, eBreadth, rCycles, T_e);
%% phase 2 results
fprintf("Ave. ctl. predicted error, %f \n", ave_pred_error_c);
fprintf("Ave. exp. predicted error, %f \n", ave_pred_error_e);

% energy
figure
subplot(2,1,1)
x = 1:size(energies_cAR, 2);
y1 = energies_cAR;
plot(x,y1)
title(sprintf("Ctl. AR energy"))
xlabel('steps');
ylabel('energy');

subplot(2,1,2);
y2 = energies_eAR;
plot(x,y2)
title(sprintf("Exp. AR energy"));
xlabel('steps');
ylabel('energy');

% error
figure
subplot(2,1,1)
x = 1:size(errors_cAR, 2);
y1 = errors_cAR;
plot(x,y1)
title(sprintf("Ctl. AR error"))
xlabel('steps');
ylabel('error');

subplot(2,1,2);
y2 = errors_eAR;
plot(x,y2)
title(sprintf("Exp. AR error"));
xlabel('steps');
ylabel('error');

% free recall
figure
subplot(2,1,1)
x = 1:size(energies_cFR, 2);
y1 = energies_cFR;
plot(x,y1)
title(sprintf("Ctl. FR energy"))
xlabel('steps');
ylabel('energy');

subplot(2,1,2);
y2 = energies_eFR;
plot(x,y2)
title(sprintf("Exp. FR energy"));
xlabel('steps');
ylabel('energy');