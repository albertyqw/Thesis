 %%%%%%%%%%%%% Begin testInput.m %%%%%%%%%%%%%%%%%%%%%
%% present a test input pattern to the input layer, update hidden layer, then do brief 
%% Gibbs sampling, alternatingly updating the input and then the hidden layer
%% run:
%%                  [weights,G] = testInput(weights, testInputPatterns(:,1));

function hiddenState = testInput(oldWeights,testInputPattern, nGibbsCycles)      
      inputState = testInputPattern; % clamp to 1st pattern
      newWeights = oldWeights;

      %%% Positive phase
      [hiddenState, hiddenProb] = forward(inputState,newWeights);
      %%% Negative phase
      for cycles = 1:nGibbsCycles
         [inputState, inputProb] = backward(hiddenState,newWeights);
         [hiddenState,hiddenProb] = forward(inputState,newWeights);
      end % for cycles
end
%%%%%%%%%%%%% End testInput.m %%%%%%%%%%%%%%%%%%%%%

