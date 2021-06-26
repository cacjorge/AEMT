function [ a_f4 ] = obj4_autoesc( f1,f2,f3 )

    m = [f1 f2 f3/1000];
    for i=1:size(m,2)
        a_m(i) = (m(i) - mean(m))/std(m);
    end
    a_f4 = sum(abs(a_m));

end

