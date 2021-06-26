function [ POP,rateTab ] = avaliaInd( IND, SUBPOP, fitness,i,tamTabela,qntFunc,j,rateTab )
%SUBPOP 
% Separa os individuos em cada subpopulação
    
    x = size(SUBPOP,1);
    y = size(SUBPOP,2);
    yy = y-qntFunc;
  
    if (isempty(SUBPOP))
        SUBPOP(1,:) = [ IND{1,i}.ind(1,:) fitness];
    else 
        repetido = 0;
        for k=1:x
            if(isequal(SUBPOP(k,[1:yy]),IND{1,i}.ind(1,:)))
                repetido = 1;
                break;
            end
        end 
        
        if(repetido == 0)
            %para o caso em que a tabela já está preenchida        
            if(x >= tamTabela)
                [aux,pos] = max(SUBPOP(:,yy+j));
                
                if fitness(j) < SUBPOP(pos,yy+j)
                    SUBPOP(pos,:) = [IND{1,i}.ind(1,:) fitness];
                    rateTab(IND{1,i}.tab) = rateTab(IND{1,i}.tab)+1;
                end
            else
                SUBPOP(x+1,:) = [ IND{1,i}.ind(1,:) fitness];
            end
        end
    end
    POP = SUBPOP;
end