nGibbsCycles = 10;
rinputState = rand(nInputs);
rhiddenState = rand(5); % size of hidden states

% how to get just 4 hidden unit network?
hamming = zeros(nTrainingPatterns, 100);
mhamming = zeros(1, 100);
pattern = zeros(1, 100);

for f = 1:100 % 100 repititons
    inputActivation = testUnclamped(weightsa{2},rinputState, rhiddenState, nGibbsCycles);
    for g = 1:nTrainingPatterns
        for h = 1:nInputs
            if inputActivation(h) ~= trainingPatterns(h,g)
                hamming(g,f) = hamming(g,f) + 1;
            end
        end
    end
    [M,I] = min(hamming(:,f));
    mhamming(f) = M;
    pattern(f) = I;
end
figure
plot(mhamming)
title("Hamming distance")

figure
plot(pattern)
title("Training Pattern")
    

