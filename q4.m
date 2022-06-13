% test hidden, try x100, for all patterns
nGibbsCycles = 5; % q5: gets us closer to input patterns!

for d = 1:size(testHiddenPatterns,1)
    inputPatterns{d} = testHidden(cell2mat(weightsa(2)), testHiddenPatterns(:,d), nGibbsCycles);
    for e = 1:99
        inputPatterns{d} = inputPatterns{d} + testHidden(weightsa{2}, testHiddenPatterns(:,d), nGibbsCycles);
    end
    figure
    heatmap(inputPatterns{d})
end
title("input patterns heatmap");