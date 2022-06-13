%%%%%%%%%%%%% Begin testUnclamped.m %%%%%%%%%%%%%%%%%%%%%
function inputActivation = testUnclamped(oldWeights,rinputState, rhiddenState, nGibbsCycles)      
      inputState = rinputState; % start from random input
      hiddenState = rhiddenState; % start from random hidden
      newWeights = oldWeights;

      %%% Positive phase
      [hiddenState, hiddenProb] = forward(inputState,newWeights);
      %%% Negative phase
      for cycles = 1:nGibbsCycles
         [inputState, inputProb] = backward(hiddenState,newWeights);
         [hiddenState,hiddenProb] = forward(inputState,newWeights);
      end % for cycles
      inputActivation = inputState;
end

    
%%%%%%%%%%%%% End testUnclamped.m %%%%%%%%%%%%%%%%%%%%%
