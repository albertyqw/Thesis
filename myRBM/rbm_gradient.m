function [Mgrad, bgrad, cgrad] = rbm_gradient(v0, h0, vk, hk)
    % compare data vector with reconstruction samples
    Mgrad = (v0 * h0') - (vk * hk'); % v0 given, h0 from positive - validate that this follows hinton's learning rule
    bgrad = (v0 - vk); % setting this to 0 or 1, and the model doesn't really learn
    cgrad = (h0 - hk);
end
