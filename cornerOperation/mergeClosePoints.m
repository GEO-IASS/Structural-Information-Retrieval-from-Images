%% Merge points that are close to each other
% Works on 2-d points only
% May not remove all close points, but can reduce the scale of the problem
% for exhaustive searching

function mergedPoints = mergeClosePoints(P, thres, n, times)
    p = P;
    for i = 1:times
        shiftvec = circshift([1,2],i,2);
        p = sortrows(p, shiftvec);
        pdiff = diff([repmat(p(1,:)+2*thres, [n,1]);p],n,1);
        mask = (abs(pdiff(:,1)) < thres) & (abs(pdiff(:,2)) < thres);
        idx = cumsum(~mask);
        
        xmean = accumarray(idx,p(:,1),[],@mean);
        ymean = accumarray(idx,p(:,2),[],@mean);
        p = [xmean, ymean];
    end
    
    mergedPoints = p;
end