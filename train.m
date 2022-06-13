%%%%%%%%%%%%  Begin train.m %%%%%%%%%%%%%%%%%%%
%% Copy and paste this section of the code into a script file called train.m
%% To train a new network, first run the initialization script init.m from the command line, then
%% repeatedly call this function from the command line until training has converged.
%% To call this function from the command line, use the following code:
%%                  [weights,G] = train(weights, nLearnReps, K, epsilon, trainingPatterns,weightCost);
function [newWeights,G] = train(oldWeights,nReps,nGibbsCycles,epsilon,trainingpatterns,weightCost)      
      nPatterns = size(trainingpatterns,2);
      newWeights = oldWeights;
      nInputs = size(newWeights,2);
      nHidden = size(newWeights,1);
      for rep = 1:nReps
         G = 0;
         weightDelta = zeros(nHidden,nInputs);
         for pat = 1:nPatterns              
              %%% Positive phase
              inputState = trainingpatterns(:,pat);
              [hiddenState,hiddenProb] = forward(inputState,newWeights);
              weightDelta = weightDelta + epsilon * hiddenState .* (inputState)';
              G = G + calcEnergy(inputState, hiddenState, newWeights);
              %%% Negative phase
              for cycles = 1:nGibbsCycles
                 [inputState, inputProb] = backward(hiddenState,newWeights);
                 [hiddenState,hiddenProb] = forward(inputState,newWeights);
              end % for cycles
              weightDelta = weightDelta - epsilon * hiddenState .* (inputState)';
              G = G - calcEnergy(inputProb, hiddenProb, newWeights);
        end % for pat
        weightDelta = weightDelta/nPatterns - weightCost * newWeights;
        newWeights = newWeights + weightDelta;
        fprintf(1,"Energy diff = %f\n", G);
     end % for rep
end % train.m
%%%%%%%%%%%%  End train.m %%%%%%%%%%%%%%%%%%%
