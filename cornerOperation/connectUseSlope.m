function [lineTable, cTable] = connectUseSlope(CCC, thresholdUp, thresholdDown)
    lineTable = [];
    cTable = [];
    p = 1;
    for k = 1:size(CCC,1)
        slope = abs((CCC(:,2) - CCC(k,2)) ./ (CCC(:,1) - CCC(k,1)));
        temp = 1:size(CCC,1);
        slope = [slope, temp'];
        mask = slope(:,1) > thresholdUp | slope(:,1) < thresholdDown;
        cdt = slope(mask,2);
        dist = sqrt(sum((CCC(cdt,:) - repmat(CCC(k,:), [size(CCC(cdt,:),1),1])).^2, 2));
        dist = [dist, cdt];
        sortrows(dist);

        if size(dist,1) > 4
            up = 4;
        else
            up = size(dist,1);
        end

        if(size(dist, 1) < 1)
            continue;
        else
            for i = 1:up
                lineTable(p,1:2) = CCC(k,:);
                lineTable(p,3:4) = CCC(dist(i,2),:);
                cTable(p,1) = k;
                cTable(p,2) = dist(i,2);
                p = p+1;
            end
        end
    end
end