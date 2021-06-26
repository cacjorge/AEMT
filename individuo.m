function [ IND ] = individuo( pos,SUBPOP,qntObj,numObj)
%INDIVIDUO 

       aux1 = SUBPOP(pos(1),:);
       aux2 = SUBPOP(pos(2),:);
       aux3 = aux1(1:size(aux1,2)-qntObj);
       aux4 = aux2(1:size(aux2,2)-qntObj);
       if aux1(size(aux3,2)+numObj) < aux2(size(aux4,2)+numObj)
           IND = aux1;
       else
           IND = aux2;
       end

end

