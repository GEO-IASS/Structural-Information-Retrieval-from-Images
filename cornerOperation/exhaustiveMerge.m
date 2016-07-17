
function c = exhaustiveMerge(P, thres)
    c = [];
    p = P;
    tempN = size(p,1);
    while tempN >= 1

        distance = sum( abs( p - repmat(p(1,:), [tempN, 1]) ), 2);
        idx = find(distance < thres);
        c = [c; mean(p(idx, :), 1)];
        p([1;idx],:) = [];

        tempN = size(p, 1);
    end
    
end