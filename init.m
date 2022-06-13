%%%%%%%%%%%%  Begin init.m %%%%%%%%%%%%%%%%%%%
%% Copy and paste this section of the code into a matlab script file called init.m
%% Run this script once from the command line for each network that is being tested.
%% Then repeatedly call the function train.m from the command line until training has converged.
K = 3; %% Number of steps of brief Gibbs sampling
nHidden = 5;  %% number of hidden units including the bias unit.  
              %%% So for example, if we want 2 hidden units, set nHidden = 3, 
             %%% if we want 4 hidden units, set nHidden = 5, etc.
initPatterns;
nInputs = size(trainingPatterns,1);
nTrainingPatterns = size(trainingPatterns,2);
epsilon = 0.05;  %% the learning rate
weightCost = 0.0002;  %% used in train.m to decay weights toward zero after each learning update
weights = rand(nHidden, nInputs) - 0.5;   %%% random initial values
nLearnReps = 100;  %% Keep training in blocks of 100 learning iterations until convergence 
%%% (i.e. until G-error seems to be converging to a minimum, although it will bounce up and down %%% a bit due to stochasticity of unit states in learning equations, it should on average be 
%%% decreasing).
%%%%%%%%%%%%  End init.m %%%%%%%%%%%%%%%%%%%
