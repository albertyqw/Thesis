%%%%%%%%%%%%  Begin backward.m %%%%%%%%%%%%%%%%%%%
%% Copy and paste this section of the code into a matlab m-file called backward.m
%% This function is called by several other functions below.
% Propagate activations from hidden layer to input layer
function [inputState,inputProb] = backward(hiddenState, weights)
   netInput = weights' * hiddenState; %% use transposed weights for top-down activations
   nInputs = size(weights,2);
   inputProb = 1.0 ./ (1.0 + exp(-netInput));  %% prob of unit on according to sigmoid fn
   inputState = (1.0)*(rand(nInputs,1) < inputProb); %% Probabilistic Binary activations      inputState(nInputs,1) = 1.0;   %% Always keep the final bias unit’s state equal to  1
%%%%%%%%%%%%  End backward.m %%%%%%%%%%%%%%%%%%%
