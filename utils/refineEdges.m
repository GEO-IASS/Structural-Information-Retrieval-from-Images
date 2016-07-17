%% This function tries to find closed loop from a BW image
% thres : connected area with less than thres pixels are treated as small
% cSense : area with dx and dy >= sSense are circle candidates


function [CC, seq, removed_lines] = refineEdges(BW, nConn, thres, cJudge, cSense)
    % find connectivities
    CC = bwconncomp(BW, nConn);
    removed_lines = [];
    M = CC.ImageSize;
    num_conn = CC.NumObjects;
    for i = 1:num_conn
        seq = sort(cell2mat(CC.PixelIdxList(i)));
        [px, py] = arrayfun(@seqnum2Point, seq);
        mx = mean(px);
        my = mean(py);
        dx = max(px - mx);
        dy = max(py - my);
        sx = max(px) - min(px);
        sy = max(py) - min(py);

        if abs(numel(px) - 2*(sx + sy)) < cJudge && numel(px) < thres && ...
             (abs(dx) >= cSense) && (abs(dy) >= cSense)
            removed_lines = [removed_lines, i];
        end
    end
    
    function [x,y] = seqnum2Point(c)
        x = floor(c/M(1)) + 1;
        y = c - (x-1)*M(1);
    end
end