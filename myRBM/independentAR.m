%% independent associative recall

ts = [4,3,2,19,5,9,12,18,62,8]; % samples digits 0:9 for associative recall

cBreadth = 0.95; % 0.95 % of neurons kept on for the control case
eBreadth = 0.90; % 0.90 """ for the experimental (trait rumination case)

aCycles = 3; % number of AR sampling points
acdk_c = 80; % associative recall k-steps / cycle
acdk_e = 80;

% maxcdk_c = acdk_c*acycles*length(ts); % max cdk counter
% maxcdk_e = acdk_e*acycles*length(ts);

% errors and energies for ctl. vs exp.
errors_cAR = [];
energies_cAR = [];
errors_eAR = [];
energies_eAR = [];

pred_error_c = [];
pred_error_e = [];

% RBM "predicted" image labels
imPred_c = [];
imPred_e = [];

% temperatures
T_c = 1.1; % higher for control, increases neuron firing
T_e = 0.9;

% mood, keep 0 for independent AR
mood_c = 0;
mood_e = 0;

% AR test
% control
figure
title(sprintf("Ctl. Independent AR"))
for i = 1:length(ts)
    [error_cAR, energy_cAR, imPred_c] = AR(M_c, acdk_c, b_c, c_c, tsImagesL(ts(i),:), tsValences(ts(i))*10, ...
        "ctl.", nhidden, cBreadth, aCycles, T_c, mood_c);

    % adding statistics to matrix
    errors_cAR = [errors_cAR; error_cAR];
    energies_cAR = [energies_cAR; energy_cAR];

    pred_error_c(end+1) = imPred_c;
end

figure
title(sprintf("Exp. Independent AR"))
for i = 1:length(ts)
    [error_eAR, energy_eAR, imPred_e] = AR(M_e, acdk_e, b_e, c_e, tsImagesL(ts(i),:), tsValences(ts(i))*10, ...
        "exp.", nhidden, eBreadth, aCycles, T_e, mood_e);
    errors_eAR = [errors_eAR; error_eAR];
    energies_eAR = [energies_eAR; energy_eAR];
    pred_error_e(end+1) = imPred_e;
end
%% results
% "prediction" error
ave_pred_error_c = (sum(abs([0:9]-pred_error_c)))/10;
ave_pred_error_e = (sum(abs([0:9]-pred_error_e)))/10;

fprintf("Ave. ctl. predicted error =  %.3f \n ctl. std = %.3f \n", ave_pred_error_c, std(pred_error_c));
fprintf("Ave. exp. predicted error =  %.3f \n exp. std = %.3f \n", ave_pred_error_e, std(pred_error_e));

% ctl. energies
figure
xv = linspace(0, size(energies_cAR, 2), size(energies_cAR,2));
plot(xv, energies_cAR)

leg = string([0:9]);
legend(leg)
grid
title(sprintf("Ctl. AR energies"))
xlabel('steps')
ylabel('energy')

% ctl. errors
figure
xv = linspace(0, size(errors_cAR, 2), size(errors_cAR,2));
plot(xv, errors_cAR)

legend(leg)
grid
title(sprintf("Ctl. AR errors"))
xlabel('steps')
ylabel('error')

% ctl. energy vs. exp. energy
ave_energy_cAR = mean(energies_cAR);
ave_energy_eAR = mean(energies_eAR);

std_energy_cAR = std(energies_cAR);
std_energy_eAR = std(energies_eAR);

figure
errorbar(1:length(ave_energy_cAR), ave_energy_cAR, std_energy_cAR);
hold on;
errorbar(1:length(ave_energy_eAR), ave_energy_eAR, std_energy_eAR);
hold off;
title(sprintf("Ctl. vs. exp. mean energy"))
legend('ctl.', 'exp.')
xlabel('steps');
ylabel('energy');

% ctl. error vs. exp. error
ave_error_cAR = mean(errors_cAR);
ave_error_eAR = mean(errors_eAR);

std_error_cAR = std(errors_cAR);
std_error_eAR = std(errors_eAR);

figure
errorbar(1:length(ave_error_cAR), ave_error_cAR, std_error_cAR);
hold on;
errorbar(1:length(ave_error_eAR), ave_error_eAR, std_error_eAR);
hold off;
title(sprintf("Ctl. vs. exp. mean error"));
legend('ctl.', 'exp.')
xlabel('steps');
ylabel('error');