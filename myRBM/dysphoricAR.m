%% dysphoric induction AR

ts_dys = [2,36,39,44,48,1,18,27,35,37]; % samples 2s then 7s, dysphoric induction followed by mood lifting

mood_c = zeros(length(ts)+1); % control and experimental mood calculation
mood_e = zeros(length(ts)+1);

cBreadth = 0.90; % 0.90 % of neurons kept on for the control case
eBreadth = 0.80; % 0.80 """ for the experimental (trait rumination case)

aCycles = 3; % number of AR sampling points

% maxcdk_c = acdk_c*acycles*length(ts); % max cdk counter
% maxcdk_e = acdk_e*acycles*length(ts);

% errors and energies for ctl. vs exp.
errors_cAR = [];
energies_cAR = [];
errors_eAR = [];
energies_eAR = [];

pred_error_c = [];
pred_error_e = [];

% RBM "predicted" images
imPred_c = [];
imPred_e = [];

% temperatures
T_c = 1.1; 
T_e = 0.9;

% mood, keep 0 for independent AR
mood_c = [0];
mood_e = [0];

% control
figure
for i = 1:length(ts_dys)
    % maxcdk_c = maxcdk_c - acdk_c;
    % maxcdk_e = maxcdk_c - acdk_c;

    % check if attentional resources are overconsumed
    % if maxcdk_c < 0
        % acdk_c = acdk_c+maxcdk_c;
        % maxcdk_c = 0;
    % end

    acdk_c = 80; % associative recall k-steps / cycle
    acdk_c = mood_bias(mood_c, est_tsValences(ts_dys(i)), acdk_c); % adjust for mood-congruency, negativity

    [error_cAR, energy_cAR, imPred_c] = AR(M_c, acdk_c, b_c, c_c, tsImagesL(ts_dys(i),:), tsValences(ts_dys(i))*10, ...
        "ctl.", nhidden, cBreadth, aCycles, T_c, mood_c(end));

    valPred_c = (imPred_c - 4.5)*2; % derive valence prediction

    mood_c(end+1) = 0.4 * mood_c(end) + 0.1 * (0.75 * valPred_c + 0.25 * est_tsValences(ts_dys(i))); % 80% prior mood + weighted average of (15%) input and (5%) interpreted valence

    % adding statistics to matrix
    errors_cAR = [errors_cAR, error_cAR];
    energies_cAR = [energies_cAR, energy_cAR];
end

% experimental
figure
for i = 1:length(ts_dys)
    acdk_e = 80;
    acdk_e = mood_bias(mood_e, est_tsValences(ts_dys(i)), acdk_e);

    [error_eAR, energy_eAR, imPred_e] = AR(M_e, acdk_e, b_e, c_e, tsImagesL(ts_dys(i),:), tsValences(ts_dys(i))*10, ...
        "exp.", nhidden, eBreadth, aCycles, T_e, mood_e(end));
    valPred_e = (imPred_e - 4.5)*2;
    mood_e(end+1) = 0.4 * mood_e(end) + 0.1 * (0.75 * valPred_e + 0.25 * est_tsValences(ts_dys(i)));

    errors_eAR = [errors_eAR, error_eAR];
    energies_eAR = [energies_eAR, energy_eAR];
end

% get non-zeros
errors_cAR = nonzeros(errors_cAR);
energies_cAR = nonzeros(energies_cAR);
errors_eAR = nonzeros(errors_eAR);
energies_eAR = nonzeros(energies_eAR);

%% results
% ctl. energies
figure
plot(energies_cAR)
hold on
plot(energies_eAR)
hold off
title(sprintf("Ctl. vs Exp. Dysphoric AR Energy"))
legend('ctl.', 'exp.')
xlabel('steps')
ylabel('energy')

% ctl. errors
figure
plot(errors_cAR)
hold on
plot(errors_eAR)
hold off
title(sprintf("Ctl. vs Exp. Dysphoric AR Error"))
legend('ctl.','exp.')
xlabel('steps')
ylabel('error')