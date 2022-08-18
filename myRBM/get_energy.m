function energy = get_energy(vk, hk, M, b, c) % seems to slow training down signficantly - is there a more efficient method?
    % joint = 0;
    % for i = 1:size(vk,1)
        % for j = 1:size(hk,1)
            % joint = joint + vk(i)*hk(j)*M(i,j);
        % end
    % end
    vhw = (vk*hk').*M; % visible, hidden, weight product
    joint = sum(vhw, 'all');
    energy = - (dot(b,vk) + dot(c,hk) + joint);