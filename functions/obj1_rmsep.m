function [ f1,b ] = obj1_rmsep(Xcal,ycal,Xval,yval,var_sel)
%RMSEP Calcula o erro de predição
    b = Xcal(:,var_sel)\ycal;
    Yp = Xval(:,var_sel)*b;
    f1 = sumsqr(Yp-yval)/size(Yp,1);
end

