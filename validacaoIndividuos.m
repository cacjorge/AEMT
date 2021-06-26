function [ new_filhos ] = validacaoIndividuos( new_filhos,m_min,m_max,K )
%VALIDACAOINDIVIDUO Summary of this function goes here
%   Detailed explanation goes here
    for filho=1:size(new_filhos,1)
        m = sum(new_filhos(filho,:)); % Number of selected variables
        if (m < m_min) % A new wavelength must be included
            while (m < m_min)
                j = find(new_filhos(filho,:)==0);
                m = sum(new_filhos(filho,:));
                include = ceil((K-m)*rand);  % A random wavelength is included
                new_filhos(filho,j(include)) = 1;
            end
        elseif (m > m_max) % A wavelength must be excluded
            while (m > m_max)
                j = find(new_filhos(filho,:)==1);
                m = sum(new_filhos(filho,:));
                exclude = ceil(m*rand);	% A random wavelength is excluded
                new_filhos(filho,j(exclude)) = 0;
            end
        end
    end

end

