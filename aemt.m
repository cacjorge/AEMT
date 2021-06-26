function [TABELA] = aemt(P,MaxGenerations,tamTabela,m_min,m_max,Xcal,ycal,Xval,yval)

% [TABELA] = aemt(P,MaxGenerations,tamTabela,m_min,m_max,Xcal,ycal,Xval,yval)
%
% Input arguments:
%
% P --> Constant number of individuals in the population (must be even)
% MaxGenerations --> Maximum number of generations
% tamTabela --> Size of each objective table.
% m_min,m_max  --> Lower and Upper limits for the number of variables to include in the MLR model
%
% If m_min = [], the default value m_min = 1 is employed
% If m_max = [], the default values m_max = min(N-1,K) (validation with a separate set)
% or min(N-2,K) (cross-validation) are employed.
%
% Xcal,ycal,Xval,yval --> Calibration and validation data
% Xcal,ycal --> Calibration data for use with cross-validation
%
% Output arguments:
% POPULACAO --> returns the initial population along with all objective
% tables.

close all;
clc;
if rem(P,2)~=0
    error('P must be even !')
end

pc = 0.7; % Crossover probability
pm = 0.5; % Mutation probability
prob_mut_gene = 0.3;
N = size(Xcal,1); % Number of calibration objects
K = size(Xcal,2); % Chromosome length = Total number of variables;

if length(m_min) == 0, m_min = 1; end
if length(m_max) == 0,
    if size(Xval,1) > 0
        m_max = min(N-1,K);
    else
        m_max = min(N-2,K);
    end
end

if m_max > min(N-1,K)
    error('m_max is too large !');
end

addpath('functions','operators');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%  Inicialização da população e subpopulações  %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
POPINI = zeros(P,K);
TABELA = {};
TABELA_PROX = {};
TABELA{2,1} = []; %% vetor de valores de fitness das tabelas;

lista_funcoes = dir('functions/*.m');
quantidade_funcoes = size(lista_funcoes,1);
for i=1:quantidade_funcoes
    nome_funcoes{i} = lista_funcoes(i).name(1:size(lista_funcoes(i).name,2)-2);
    TABELA{1,i} = [];
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% Geração aleatória da população inicial  %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:P
    m = m_min + sum(round(randi([m_min,m_max])));
    dummy = randperm(K);
    var_sel = dummy(1:m);
    POPINI(i,var_sel)=ones(1,m);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%   Avaliação dos individuos gerados e   %%%%%%%%
%%%%%%%%%%%%   Separação da população de acordo com %%%%%%%%
%%%%%%%%%%%%   os respectivos objetivos             %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:P
    fitness = avalia(Xcal,ycal,Xval,yval,POPINI(i,:),nome_funcoes);
    for j=1:quantidade_funcoes
        TABELA{1,j} = subpop(POPINI,TABELA{1,j},fitness,i,tamTabela,quantidade_funcoes,j);
        TABELA{2,1}(j) = 0;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% Início do Ciclo Evolutivo  %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for n = 1:MaxGenerations
        POPINI = [];
        TABELA_PROX = TABELA;
        
        for i = 1:tamTabela*quantidade_funcoes
            %%%%%%%%%%%%%%%%%
            % Método do torneio para cada tabela
            IND = torneio(TABELA,tamTabela,quantidade_funcoes);
            
            father = IND{1,1}.ind(:,[1:size(IND{1,1}.ind,2)-quantidade_funcoes]);
            mother = IND{1,2}.ind(:,[1:size(IND{1,2}.ind,2)-quantidade_funcoes]);

            %%%%%%%%%%%%%%%%
            % Cruzamento
            son = father; % Default
            daughter = mother; % Default
            func_ = eval(['@' 'uniform_crossover']);
            [son,daughter] = func_(father,mother,pc);

            %%%%%%%%%%%%%%%%%
            % Mutação
            new_filhos = [son;daughter];
            func_ = eval(['@' 'gene_mutation']);
            new_filhos = func_(new_filhos,pm,prob_mut_gene);

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%   Validação dos individuos gerados  %%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            new_filhos = validacaoIndividuos(new_filhos,m_min,m_max,K);
            %POPINI = [POPINI;new_filhos];
            
            IND{1,1}.ind = new_filhos(1,:);
            IND{1,2}.ind = new_filhos(2,:);
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%   Avaliação dos individuos gerados e   %%%%%%%%
            %%%%%%%%%%%%   inclusão dos mesmos nas respectivas  %%%%%%%%
            %%%%%%%%%%%%   tabelas de cada objetivo             %%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            for filho=1:size(IND,2)
                fitness = avalia(Xcal,ycal,Xval,yval,IND{1,filho}.ind,nome_funcoes);
                for j=1:quantidade_funcoes
                    [TABELA_PROX{1,j},rateTab] = avaliaInd(IND,TABELA_PROX{1,j},fitness,filho,tamTabela,quantidade_funcoes,j,TABELA_PROX{2,1});
                    TABELA_PROX{2,1} = rateTab;
                end
            end
        end
        TABELA = TABELA_PROX;

    
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%% Fim do Ciclo Evolutivo  %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

