clear;
clc;
load dados_pronto_trigo_nir_corrigido.mat;
m_min = 1;
m_max = 50;

h = waitbar(0,'Começando execuções... Aguarde');
loopStart = now;

for numInd=50:50:200
    for numGer=50:50:numInd*2
        for numTab=10:10:20
            for exe=1:30
                mkdir([sprintf('dados_%i_%i_%i_%i_%i',numInd,numGer,numTab,m_min,m_max)]);
                loopEnd = loopStart + (now-loopStart)*exe;
                waitbar(exe/30,h,['Execução: ' num2str(exe) ' - ' num2str(numInd) ' - ' num2str(numGer) ' - ' num2str(numTab)]);
                [TABELA] = aemt(numInd,numGer,numTab,m_min,m_max,Xcal,Ycal,Xval,Yval);
                avalia_predicao;
                save([sprintf('dados_%i_%i_%i_%i_%i/execucao_%i.mat',numInd,numGer,numTab,m_min,m_max,exe)],'menor_erro','cromossomo_menor_erro','TABELA');
            end
        end
    end
end
close(h);

