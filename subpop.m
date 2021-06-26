function [ POP ] = subpop( POP, SUBPOP, fitness,i,tamTabela,qntFunc,j )
%SUBPOP 
% Separa os individuos em cada subpopulação
    
    x = size(SUBPOP,1);
    y = size(SUBPOP,2);
    yy = y-qntFunc;
  
    if (isempty(SUBPOP))
        SUBPOP(1,:) = [ POP(i,:) fitness];
    else 
        repetido = 0;
        for k=1:x
            if(isequal(SUBPOP(k,[1:y-qntFunc]),POP(i,:)))
                repetido = 1;
                break;
            end
        end 
        
        if(repetido == 0)
            %para o caso em que a tabela já está preenchida        
            if(x >= tamTabela)
                [aux,pos] = max(SUBPOP(:,yy+j));
                
                if fitness(j) < SUBPOP(pos,yy+j)
                    SUBPOP(pos,:) = [POP(i,:) fitness];
                end
            else
                SUBPOP(x+1,:) = [ POP(i,:) fitness];
            end
        end
    end
    POP = SUBPOP;
end