%% rumination
% manual
loadData

epsilon1 = 0.001;
epsilon2 = 0.01; % ruminatory

ts = [4,3,2,19,5,19,5,9,12,18,62,8];

[M1, b1, c1, errors1] = rbm(epsilon1, Ni, trImages);
[M2, b2, c2, errors2] = rbm(epsilon2, Ni, trImages); % ruminatory

for i = 1:length(ts)
    test_input(M1, 10, c1, b1, tsImages(ts(i),:), "control");
    test_input(M2, 10, c2, b2, tsImages(ts(i),:), "rumination");
end

v0 = rand(Ni,1);
test_unclamped(M1, 10, c1, b1, v0);
test_unclamped(M2, 10, c2, b2, v0);