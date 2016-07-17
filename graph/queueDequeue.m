function [nq,nf,nr,d] = queueDequeue(q,f,r)
    if q < f
        d = q(f);
        nf = f + 1;
    else
        warning('Queue Empty.');
        d = NaN;
    end
end