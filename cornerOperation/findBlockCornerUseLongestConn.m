function bC = findBlockCornerUseLongestConn(CCC,BW,width,quadset)
    bC = [];
    if isempty(quadset)
        quadset = getQuadConnectionPointSet(CCC,BW,width,5,[1,-1]);
    end
    
    for p = 1:size(CCC,1)
        for m = 1:4
            if isempty(quadset{p,m})
                continue;
            end
            dist = sum(abs( repmat(CCC(p,:), [size(CCC(quadset{p,m},:),1),1]) - CCC(quadset{p,m},:)),2);
            [~,maxpos] = max(dist);
            bC = [bC,quadset{p,m}(maxpos)];
        end
    end
end