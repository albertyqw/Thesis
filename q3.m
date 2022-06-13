% test input, try x100
nGibbsCycles = 5;

for b = 1:length(nHidden)
    hiddenPatterns{b} = testInput(weightsa{b}, testInputPatterns(:,1), nGibbsCycles);
    for c = 1:99
        hiddenPatterns{b} = hiddenPatterns{b} + testInput(weightsa{b},testInputPatterns(:,1), nGibbsCycles);
    end
    figure
    heatmap(hiddenPatterns{b})
    title("hidden patterns heatmap");
end

% varies significantly
