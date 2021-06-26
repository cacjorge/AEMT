function [ new_children ] = gene_mutation( new_children,pm,prob_mut_gene )

tam_cromossomo = size(new_children(1,:),2);
for child=1:size(new_children,1)
    if rand < pm % Mutation takes place
        for gene=1:tam_cromossomo
            if(rand < prob_mut_gene)
                new_children(child,gene) = ~new_children(child,gene);
            end
        end
    end
end

end

