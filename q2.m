%%%%%%%%%%%%  Begin q2.m %%%%%%%%%%%%%%%%%%%
%% remember to clear variables!
K = 3; %% Number of steps of brief Gibbs sampling
nHidden = [2,4,6,8];  %% number of hidden units including the bias unit.  
              %%% So for example, if we want 2 hidden units, set nHidden = 3, 
             %%% if we want 4 hidden units, set nHidden = 5, etc.
initPatterns;
nInputs = size(trainingPatterns,1); % 13
nTrainingPatterns = size(trainingPatterns,2); % 28
epsilon = 0.05;  %% the learning rate
weightCost = 0.0002;  %% used in train.m to decay weights toward zero after each learning update
nLearnReps = 100;  %% Keep training in blocks of 100 learning iterations until convergence 
%%% (i.e. until G-error seems to be converging to a minimum, although it will bounce up and down %%% a bit due to stochasticity of unit states in learning equations, it should on average be 
%%% decreasing).

% train each layer
% G = zeros(length(nHidden)); % store energies - not necessary
% weightsa = [zeros(2,28); zeros(4,28); zeros(6,28); zeros(8,28)];

for a = 1:length(nHidden)
    weights = rand(nHidden(a), nInputs) - 0.5;   %%% random initial values
    % train x3
    for c = 1:3
        [weightsa{a},G(a)] = train(weights, nLearnReps, K, epsilon, trainingPatterns, weightCost);
    end
end

% heatmap of weights learned
for b = 1:length(nHidden)
    figure
    heatmap(weightsa{b})
    title([num2str(nHidden(b)), " hidden layers heatmap"]);
end
