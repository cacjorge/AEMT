function [ fitness ] = avalia(Xcal,ycal,Xval,yval,individuo,nome_funcoes)
%AVALIA Summary of this function goes here
%   Detailed explanation goes here
    var_sel = find(individuo);
    func_ = eval(['@' nome_funcoes{1}]); 
    [f1,b] = func_(Xcal,ycal,Xval,yval,var_sel);
    
    func_ = eval(['@' nome_funcoes{2}]); 
    f2 = func_(individuo);
    
    func_ = eval(['@' nome_funcoes{3}]); 
    f3 = func_(b);
        
    func_ = eval(['@' nome_funcoes{4}]); 
    f4 = func_(f1,f2,f3);

    fitness = [ f1 f2 f3 f4 ];

end

