function m_cdk = mood_bias(mood, valence, cdk)
    if (valence < (mood+1)) & (valence > (mood-1))
        m_cdk = cdk * 1.1; % increase k-steps by 10%
        if mood < 0
                m_cdk = m_cdk + 0.1*cdk; % increase by another 10% k-steps again for negative mood
        end
    else
        m_cdk = cdk * 0.9; % positive, non-congruent valence
    end