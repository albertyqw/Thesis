%%%%%%%%%%%%% Begin testHidden.m %%%%%%%%%%%%%%%%%%%%%
%% present a test pattern to the hidden layer, update input layer, then do brief 
%% Gibbs sampling, alternatingly updating the hidden and then the input layer

%% present a test input pattern to the input layer, update hidden layer, then do brief 
%% Gibbs sampling, alternatingly updating the input and then the hidden layer
%% run:
%%                  [weights,G] = testInput(weights,testHiddenPatterns(:,1));

function inputState = testHidden(oldWeights,testHiddenPattern,nGibbsCycles)      
      hiddenState = testHiddenPattern; % clamp to 1st pattern
      newWeights = oldWeights;

      %%% Positive phase
      [inputState, inputProb] = backward(hiddenState,newWeights); % does this make sense? size misaligned
      %%% Negative phase
      % [inputState, inputProb] = backward(hiddenState,newWeights);
      % [hiddenState, hiddenProb] = forward(inputState,newWeights);
      for cycles = 1:nGibbsCycles
         [inputState, inputProb] = backward(hiddenState,newWeights);
         [hiddenState,hiddenProb] = forward(inputState,newWeights);
      end % for cycles
end
%%%%%%%%%%%%% End testHidden.m %%%%%%%%%%%%%%%%%%%%%
