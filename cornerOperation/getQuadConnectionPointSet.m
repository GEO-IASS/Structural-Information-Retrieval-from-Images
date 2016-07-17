function quadset = getQuadConnectionPointSet(CCC, BW, width, thres, k)
    quadset = cell(size(CCC,1),4);
    for p = 1:size(CCC,1)
        k1 = k(1); b1 = -k1*CCC(p,1) + CCC(p,2);
        k2 = k(2); b2 = -k2*CCC(p,1) + CCC(p,2);
        % assign points into four quadrants
        series = 1:size(CCC,1);
        series(p) = [];
        for m = series
            x = CCC(m,1);
            y = CCC(m,2);
            
            % remove a target candidate if the line segment goes across large part of
            % darkness

            [~,zs] = getMaxZeroLength(CCC(p,:), CCC(m,:), BW, width);
            
            if zs > thres
                continue;
            end
            
            % put the valid candidates into the quadset
            if y >= k1*x+b1 && y < k2*x+b1
                quadset{p,1} = [quadset{p,1},m];
            elseif y > k1*x+b1 && y >= k2*x+b2
                quadset{p,2} = [quadset{p,2},m];
            elseif y <= k1*x+b1 && y > k2*x+b2
                quadset{p,3} = [quadset{p,3},m];
            elseif y < k1*x+b1 && y <= k2*x+b2
                quadset{p,4} = [quadset{p,4},m];
            end
        end
    end
end