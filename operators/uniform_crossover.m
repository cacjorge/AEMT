function [ son,daughter ] = uniform_crossover( father,mother,pc )

son = father;
daughter = mother;
if rand < pc % Crossover takes place
    mask = round(rand(1,size(father,2)));
    for i=1:size(mask,2)
        if mask(i)==0
            son(i)=father(i);
            daughter(i) = mother(i);
        else
            son(i)=mother(i);
            daughter(i) = father(i);
        end
    end
    
end


end

