function [Mgrad, bgrad, cgrad] = rbm_gradient(v0, h0, vk, hk)
    % compare data vector with reconstruction samples
    Mgrad = (v0 * h0') - (vk * hk'); % v0 given, h0 from positive
    bgrad = (v0 - vk);
    cgrad = (h0 - hk);
end
