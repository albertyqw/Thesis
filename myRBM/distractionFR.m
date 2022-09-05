%% distraction free recall
rcdk = 40; % # k-steps per free recall
rCycles = 7; % number of ruminative "cycles" (giving us 4*30=120 total k-steps)

figure
mood = 0;

energy_cFR = 0;
energy_eFR = 0;
energies_cFR = [];
energies_eFR = [];

d = 4; % disractor point
dis = [-0.5, 0.5, 0.9];

for i = 1:length(dis)
    energy_cFR = dFR(M_c, rcdk, b_c, c_c, v0, nhidden, cBreadth, rCycles, T_c, mood, d, dis(i));
    energy_eFR = dFR(M_e, rcdk, b_e, c_e, v0, nhidden, eBreadth, rCycles, T_e, mood, d, dis(i));

    energies_cFR = [energies_cFR;energy_cFR];
    energies_eFR = [energies_eFR;energy_eFR];
end
%% results
% ctl. FR energies
figure
xv = linspace(0, size(energies_cFR, 2), size(energies_cFR,2));
plot(xv, energies_cFR)

leg = string(dis);
legend(leg)
grid
title(sprintf("Ctl. FR energies"))
xlabel('steps')
ylabel('energy')

% exp. FR energies
figure
xv = linspace(0, size(energies_eFR, 2), size(energies_eFR,2));
plot(xv, energies_eFR)

leg = string(dis);
legend(leg)
grid
title(sprintf("Exp. FR energies"))
xlabel('steps')
ylabel('energy')

% Average ctl. vs exp. FR energies
ave_energy_cFR = mean(energies_cFR);
ave_energy_eFR = mean(energies_eFR);

std_energy_cFR = std(energies_cFR);
std_energy_eFR = std(energies_eFR);

figure
errorbar(1:length(ave_energy_cFR), ave_energy_cFR, std_energy_cFR);
hold on;
errorbar(1:length(ave_energy_eFR), ave_energy_eFR, std_energy_eFR);
hold off;
title(sprintf("Ctl. vs. Exp. Mean Energy"))
legend('ctl.', 'exp.')
xlabel('steps');
ylabel('energy');