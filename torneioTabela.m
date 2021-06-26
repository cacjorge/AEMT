function [ TABS ] = torneioTabela( TABELA )
%TORNEIOTABELA Summary of this function goes here
%   Detailed explanation goes here
    
    qntTabelas = size(TABELA,2);
    TABS = 0;
    
    for i=1:2
        Tabelas_Selecionadas = randperm(qntTabelas,2);
        rateTab = [TABELA{2,1}(Tabelas_Selecionadas(1)) TABELA{2,1}(Tabelas_Selecionadas(2))];
        if rateTab(1) == rateTab(2)
            pos = round(mod(rand,rand));
            pos=pos+1;
        else
            [valor,pos] = max(rateTab);
        end    
        TABS(i) = Tabelas_Selecionadas(pos);
    end
    
end

