function [valences] = amygdala(tsPredY)
    valences = [];
    for b = 1:size(tsPredY, 2)
        valence = 0;
        for a = 1:size(tsPredY, 1)
            valence = valence + tsPredY(a,b)*(a-5.5); % scale around 0    
        end
        valences(end+1) = valence;
    end
end