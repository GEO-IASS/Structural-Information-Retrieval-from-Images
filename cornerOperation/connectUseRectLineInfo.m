%% for a point pair in CCC, draw a rectangle. A pair is considered connected if this rectangle contains
% at least one straight line.

function [lineTable, cTable] = connectUseRectLineInfo(CCC, thresholdUp, thresholdDw, BW, thresholdPointCount, thresholdZeroSeq)
    lineTable = [];
    cTable = [];
    s = 1;
    
    for k = 1:size(CCC,1)
        % find candidates using slope
        slope = abs((CCC(:,2) - CCC(k,2)) ./ (CCC(:,1) - CCC(k,1)));
        temp = 1:size(CCC,1);
        slope = [slope, temp'];
        
        judgeValue = [];
        totalPoints = [];
        maxZeroSeq = [];
        
        % find vertical candidates
        mask1 = slope(:,1) > thresholdUp;
        cdt = slope(mask1,2);
        if ~isempty(cdt)
            for q = 1:size(cdt,1)
                point1.x = int32(CCC(k,1)); point1.y = int32(CCC(k,2));
                point2.x = int32(CCC(cdt(q),1)); point2.y = int32(CCC(cdt(q),2));
                [judgeValue(q), totalPoints(q), maxZeroSeq(q)] = getOnes(point1, point2, slope(cdt(q),1), BW, thresholdUp, thresholdDw);
            end

            jv = abs(judgeValue - totalPoints);
            [minval,minpos] = min(jv);
            if jv(minpos) / (totalPoints(minpos)) < thresholdPointCount && maxZeroSeq(minpos) < thresholdZeroSeq
                lineTable(s,1:2) = CCC(k,:);
                lineTable(s,3:4) = CCC(cdt(minpos),:);
                cTable(s,:) = [k, cdt(minpos)];
                s = s+1;
            end
        end
        
        % find horizontal candidates
        slope = abs((CCC(:,2) - CCC(k,2)) ./ (CCC(:,1) - CCC(k,1)));
        temp = 1:size(CCC,1);
        slope = [slope, temp'];
        judgeValue = [];
        totalPoints = [];
        mask2 = slope(:,1) < thresholdDw;
        cdt = slope(mask2,2);
        if ~isempty(cdt)
            for q = 1:size(cdt,1)
                point1.x = int32(CCC(k,1)); point1.y = int32(CCC(k,2));
                point2.x = int32(CCC(cdt(q),1)); point2.y = int32(CCC(cdt(q),2));
                [judgeValue(q), totalPoints(q), maxZeroSeq(q)] = getOnes(point1, point2, slope(cdt(q),1), BW, thresholdUp, thresholdDw);
            end
            jv = abs(judgeValue - totalPoints);
            [~,minpos] = min(jv);
            if jv(minpos) / (totalPoints(minpos)) < thresholdPointCount && maxZeroSeq(minpos) < thresholdZeroSeq
                lineTable(s,1:2) = CCC(k,:);
                lineTable(s,3:4) = CCC(cdt(minpos),:);
                cTable(s,:) = [k, cdt(minpos)];
                s = s+1;
            end
        end
    end
end