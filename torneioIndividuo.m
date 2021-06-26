function [ IND ] = torneioIndividuo( selTab, TABELA,tamTabela,quant_funcoes )
%TORNEIOINDIVIDUO Summary of this function goes here
%   Detailed explanation goes here

    IND = [];
    for i=1:size(selTab,2)
        selInd = randperm(tamTabela,2);
        IND(i,:) = individuo(selInd,TABELA{1,selTab(i)},quant_funcoes,selTab(i));
                                                                    %número do
                                                                    %objetivo
    end

end

