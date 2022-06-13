%%%%%%%%%%%%  Begin forward.m %%%%%%%%%%%%%%%%%%%
%% Copy and paste this section of the code into a matlab m-file called forward.m
%% This function is called by several other functions below.
% Propagate activations from input layer to hidden layer
function [hiddenState,hiddenProb] = forward(inputState, weights)
   netInput = weights * inputState;
   nHidden = size(weights,1);
   hiddenProb = 1.0 ./ (1.0 + exp(-netInput)); %% prob of unit on according to sigmoid fn
   hiddenState = (1.0)*(rand(nHidden,1) < hiddenProb); %% Probabilistic Binary activations
   hiddenState(nHidden,1) = 1.0;   %% Always keep the final bias unit’s state equal to 1
%%%%%%%%%%%%  End forward.m %%%%%%%%%%%%%%%%%%%
