function [totalCount, maxZeroSeqLength] = getMaxZeroLength(p1, p2, BW, width)
    totalCount = 0;
    maxZeroSeqLength = 0;
    k = (p2(2) - p1(2)) / (p2(1) - p1(1));
    [p1(1),p1(2),p2(1),p2(2),k];
    absk = abs(k);
    b = -k*p1(1) + p1(2);
    
    if absk < 1
        x = min([p1(1),p2(1)]):max([p1(1),p2(1)]);
        if absk ~= 0
            y = k*x + b;
        else
            y = repmat(p1(2),[1,size(x,2)]);
        end
    else
        y = min([p1(2),p2(2)]):max([p1(2),p2(2)]);
        if absk ~= inf
            x = (y-b)/k;
        else
            x = repmat(p1(1),[1,size(y,2)]);
        end
    end
    pair = int32([x',y']);
    totalCount = size(pair,1);
    
    tmpCount = 0;
    
    for m = 1:totalCount
        [k,m,pair(m,:)];
        if sum(sum(BW(pair(m,2)-width:pair(m,2)+width, pair(m,1)-width:pair(m,1)+width))) == 0
            tmpCount = tmpCount + 1;
        else
            if tmpCount > maxZeroSeqLength
                maxZeroSeqLength = tmpCount;
            end
        end
    end
end