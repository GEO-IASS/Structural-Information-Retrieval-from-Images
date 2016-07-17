%% Merge two rectangles if they are overlapping
% Usage:
%   mergedRectPos = mergeOverlappingRectangles(rectPos);
% Input arguments:
%   rectPos: an M*4 array, each row of which is [x,y,w,h] indicating the
%   position of a rectangle
% Output arguments:
%   mergedRectPos: an N*4 array, where N <= M. Each row of it is the
%   position of a merged rectangle
% 
% Author: Ziwei XU
% Site: http://ziweixu.github.io
function mergedRectPos = mergeOverlappingRectangles(rectPos)
    mergedRectPos = [];
    ptr = 1;
    while ~isempty(rectPos)
        removeIdx = [1];
        flag = 0;
        
        for q = 2:size(rectPos,1)
            thisX = rectPos(1,1); thisY = rectPos(1,2); thisW = rectPos(1,3); thisH = rectPos(1,4);
            thatX = rectPos(q,1); thatY = rectPos(q,2); thatW = rectPos(q,3); thatH = rectPos(q,4);
            
            if thatX >= thisX && thatX <= thisX + thisW && thatY >= thisY && thatY <= thisY + thisH
                mergedRectPos(ptr,1) = thisX;
                mergedRectPos(ptr,2) = thisY;
                mergedRectPos(ptr,3) = max(thatX + thatW - thisX, thisW);
                mergedRectPos(ptr,4) = max(thatY + thatH - thisY, thisH);
                removeIdx = [removeIdx,q];
                flag = 1;
            elseif thatX >= thisX && thatX <= thisX + thisW && thatY + thatH >= thisY && thatY + thatH <= thisY + thisH
                mergedRectPos(ptr,1) = thisX;
                mergedRectPos(ptr,2) = min(thatY, thisY);
                mergedRectPos(ptr,3) = max(thatX + thatW - thisX, thisW);
                mergedRectPos(ptr,4) = max(thatY + thatH - thisY, thisH);
                removeIdx = [removeIdx,q];
                flag = 1;
            elseif thatX + thatW >= thisX && thatX + thatW <= thisX + thisW && thatY >= thisY && thatY <= thisY + thisH
                mergedRectPos(ptr,1) = min(thatX, thisX);
                mergedRectPos(ptr,2) = thisY;
                mergedRectPos(ptr,3) = max(thisX + thisW - thatX, thisW);
                mergedRectPos(ptr,4) = max(thisY + thisH - thatY, thisH);
                removeIdx = [removeIdx,q];
                flag = 1;
            elseif thatX + thatW >= thisX && thatX + thatW <= thisX + thisW && thatY + thatH >= thisY && thatY + thatH <= thisY + thisH
                mergedRectPos(ptr,1) = min(thatX,thisX);
                mergedRectPos(ptr,2) = min(thatY,thisX);
                mergedRectPos(ptr,3) = max(thisX + thisW - thatX, thisW);
                mergedRectPos(ptr,4) = max(thisY + thisH - thatY, thisH);
                removeIdx = [removeIdx,q];
                flag = 1;
            end
            if flag
                break;
            end
        end
        
        if flag == 0
            mergedRectPos(ptr,:) = rectPos(1,:);
        end
        ptr = ptr + 1;
        mask = ones(1,size(rectPos,1));
        mask(removeIdx) = 0;
        rectPos = rectPos(logical(mask),:);
    end
end