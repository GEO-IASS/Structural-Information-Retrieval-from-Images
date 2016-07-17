%% Merge two rectangles if they are neighbour
% Usage:
%   mergedRectPos = mergeNeighbourRectangles(rectPos, thres);
% Input arguments:
%   rectPos: an M*4 array, each row of which is [x,y,w,h] indicating the
%   position of a rectangle
% Output arguments:
%   mergedRectPos: an N*4 array, where N <= M. Each row of it is the
%   position of a merged rectangle
% 
% Author: Ziwei XU
% Site: http://ziweixu.github.io
function rectPos = mergeNeighbourRectangles(rectPos, thres)
    mergedRectPos = [];
    rectProcessed = 0;
    total = size(rectPos,1);
    while rectProcessed < total
        removeIdx = 1;
        candidate = [];
        thisX = rectPos(1,1); thisY = rectPos(1,2); thisW = rectPos(1,3); thisH = rectPos(1,4);
        
        for q = 2:size(rectPos,1)
            thatX = rectPos(q,1); thatY = rectPos(q,2); thatW = rectPos(q,3); thatH = rectPos(q,4);
            thisCentroid = [thisX + thisW / 2, thisY + thisH / 2];
            thatCentroid = [thatX + thatW / 2, thatY + thatH / 2];
            
            if sum(abs(thisCentroid - thatCentroid)) + abs(thisCentroid(1) - thatCentroid(1)) * abs(thisCentroid(2) - thatCentroid(2)) < thres
                candidate = [candidate; q, norm(thisCentroid - thatCentroid)];
            end
             
        end
        
        if ~isempty(candidate)
            candidate = sortrows(candidate,2);
            that = candidate(1,1);
            mergedRectPos(1) = min(thisX, rectPos(that,1));
            mergedRectPos(2) = min(thisY, rectPos(that,2));
%             mergedRectPos(3) = max([rectPos(candidate(1,1),1) + rectPos(candidate(1,1),3) - thisX, thisW, thisX + thisW - rectPos(candidate(1,1),1), rectPos(candidate(1,1),3)]);
%             mergedRectPos(4) = max([rectPos(candidate(1,1),2) + rectPos(candidate(1,1),4) - thisY, thisH, thisY + thisH - rectPos(candidate(1,1),2), rectPos(candidate(1,1),4)]);
            mergedRectPos(3) = max(rectPos(that,1) + rectPos(that,3), thisX + thisW) - mergedRectPos(1);
            mergedRectPos(4) = max(rectPos(that,2) + rectPos(that,4), thisY + thisH) - mergedRectPos(2);
            removeIdx = [removeIdx,that];        
%             fprintf('iter = %d\n\t%f\t%f\t%f\t%f\n\t%f\t%f\t%f\t%f\n\t', rectProcessed, thisX, thisY, thisW, thisH, ...
%             rectPos(that,1), rectPos(that,2), rectPos(that,3), rectPos(that,4));
        else
            mergedRectPos = rectPos(1,:);
%             fprintf('iter = %d\n\t%f\t%f\t%f\t%f\n\t', rectProcessed, thisX, thisY, thisW, thisH);
        end
%         fprintf('%f\t%f\t%f\t%f\n', mergedRectPos(1), mergedRectPos(2), mergedRectPos(3), mergedRectPos(4));
        mask = ones(1,size(rectPos,1));
        mask(removeIdx) = 0;
        rectPos = rectPos(logical(mask),:);
        rectPos = [rectPos; mergedRectPos];
        rectProcessed = rectProcessed + 1;
        
    end
end