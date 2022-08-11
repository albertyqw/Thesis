%% mood
loadData
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
[M, b, c, errors, energies] = rbm_mood(0.001, Ni+28, trImagesL, 100, 4, 1); % Ni + 28 for labels 

% weight heatmap
figure
title("weights heatmap")
heatmap(M);
%% recall tests
% image reshape first 784
ts = [4,3,2,19,5,9,12,18,62,8];

for i = 1:length(ts)
    [errors, energies] = test_label_input(M, 10, b, c, tsImagesL(ts(i),:), i, "control", 100, 0.99);  
end
%% phase 2 results
% energy
figure
x = 1:size(energies, 2);
y = energies;
plot(x,y)
title(sprintf("energy"))
xlabel('steps');
ylabel('energy');

% error
figure
x = 1:size(errors, 2);
y1 = errors;
plot(x,y)
title(sprintf("error"))
xlabel('steps');
ylabel('error');
