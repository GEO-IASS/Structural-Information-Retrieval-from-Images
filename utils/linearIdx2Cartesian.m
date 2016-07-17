function rc = linearIdx2Cartesian(lIdx, M) 
    c = floor(lIdx / M);
    r = lIdx - c * M;
    rc = [r,c+1];
    
    mask = rc(:,1) == 0;
    rc(mask,1) = M;
    rc(mask,2) = rc(mask,2) - 1;
end