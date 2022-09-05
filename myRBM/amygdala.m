function [valences] = amygdala(tsPredY) % converts softmax image to valence
    valences = [];
    for b = 1:size(tsPredY, 2)
        valences(end+1) = dot(tsPredY(:,b), 2*([0:9]-4.5)); % scale around [-9,9], heavier weighting going to extreme values
    end
end