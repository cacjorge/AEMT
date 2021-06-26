for k=1:size(TABELA,2)
    SUBPOP = TABELA{1,k};
    menor_erro = 9999;
    cromossomo_menor_erro = 0;
    for i=1:size(SUBPOP,1)
        cromossomo = find(SUBPOP(i,[1:690]));
        beta = Xcal(:,cromossomo)\Ycal;
        Yp = Xpred(:,cromossomo)*beta;
        erro_subpop(i) = sumsqr(Yp-Ypred)/size(Yp,1);
        if(menor_erro > erro_subpop(i))
            menor_erro = erro_subpop(i);
            cromossomo_menor_erro = SUBPOP(i,[1:690]);
        end
    end
    menor_erro;
    sum(cromossomo_menor_erro);
end