function [ IND ] = torneio( TABELA,tamTabela,quant_funcoes )
%TORNEIO
% Seleciona aleatoriamente os dois individuos para cruzamento

    IND = {};
    value1 = [];
    value2 = [];
    TABS = torneioTabela(TABELA);
    IND_ = torneioIndividuo(TABS,TABELA,tamTabela,quant_funcoes);
    
    for i=1:2
        field1 = 'ind'; value1 = IND_(i,:);
        field2 = 'tab'; value2 = TABS(i);
        IND{i} = struct(field1,value1,field2,value2);
    end
          
end

