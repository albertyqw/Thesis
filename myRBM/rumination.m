%% rumination
%% manual manipulation of learning rate
loadData

epsilon1 = 0.001;
epsilon2 = 0.01; % ruminatory

ts = [4,3,2,19,5,9,12,18,62,8];

[M1, b1, c1, errors1] = rbm(epsilon1, Ni, trImages);
[M2, b2, c2, errors2] = rbm(epsilon2, Ni, trImages); % ruminatory

for i = 1:length(ts)
    test_input(M1, 10, c1, b1, tsImages(ts(i),:), "control");
    test_input(M2, 10, c2, b2, tsImages(ts(i),:), "rumination");
end

v0 = rand(Ni,1);
test_unclamped(M1, 10, c1, b1, v0);
test_unclamped(M2, 10, c2, b2, v0);

%% phase 1 - attentional breadth (trait vs. control)
loadData

nhidden = 100; % number of hidden units - modulate - see Hinton's recipe
epsilon = 0.001;
maxEpochs = 4; % number of training epochs
cdk = 1; % contrastive-divergence steps

cBreadth = 0.99;
eBreadth = 0.90;
acdk = 100; % associative recall k-step
rcdk = 30; % rumination k-step
rCycles = 4;
v0 = rand(Ni,1); % noise

[M1, b1, c1, errors1, energies1] = rbm(epsilon, Ni, trImages, nhidden, maxEpochs, cdk);
M2 = M1; % equalize training
b2 = b1;
c2 = c1;
errors2 = errors1;

% weight heatmap
figure
title(sprintf("Weights heatmap"))
heatmap(M1);
%% recall tests
% associative recall
ts = [4,3,2,19,5,9,12,18,62,8];

for i = 1:length(ts)
    [errors1a, energies1a] = test_input(M1, acdk, b1, c1, tsImages(ts(i),:)', i, "ctl.", nhidden, cBreadth); % do we need the second "i"?
    [errors2a, energies2a] = test_input(M2, acdk, b2, c2, tsImages(ts(i),:)', i, "exp.", nhidden, eBreadth);
end

% free recall
figure
energies1b = test_unclamped(M1, rcdk, b1, c1, v0, nhidden, cBreadth, rCycles);
energies2b = test_unclamped(M2, rcdk, b2, c2, v0, nhidden, eBreadth, rCycles);
%% phase 1 results
% energy
figure
subplot(2,1,1)
x = 1:size(energies1a, 2);
y1 = energies1a;
plot(x,y1)
title(sprintf("Ctl. energy"))
xlabel('steps');
ylabel('energy');

subplot(2,1,2);
y2 = energies2a;
plot(x,y2)
title(sprintf("Exp. energy"));
xlabel('steps');
ylabel('energy');

% error
figure
subplot(2,1,1)
x = 1:size(errors1a, 2);
y1 = errors1a;
plot(x,y1)
title(sprintf("Ctl. error"))
xlabel('steps');
ylabel('error');

subplot(2,1,2);
y2 = errors2a;
plot(x,y2)
title(sprintf("Exp. error"));
xlabel('steps');
ylabel('error');

% free recall
figure
subplot(2,1,1)
x = 1:size(energies1b, 2);
y1 = energies1b;
plot(x,y1)
title(sprintf("Ctl. FR energy"))
xlabel('steps');
ylabel('energy');

subplot(2,1,2);
y2 = energies2b;
plot(x,y2)
title(sprintf("Exp. FR energy"));
xlabel('steps');
ylabel('energy');
