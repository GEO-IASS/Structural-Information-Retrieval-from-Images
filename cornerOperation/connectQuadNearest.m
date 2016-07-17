%% Connect two corners, searching for candidates from four directions
% Input Arguments:
%   CCC:
%   BW:
%   thresZS:
%   zeroDetectionWidth:
% Output Arguments:
%   cTable: 

function cTable = connectQuadNearest(CCC, BW, thresZS, zeroDetectionWidth, quadset)
    cTable = [];
%     for k = 1:size(CCC,1)
%         k1 = 1; b1 = -k1*CCC(k,1) + CCC(k,2);
%         k2 = -1; b2 = -k2*CCC(k,1) + CCC(k,2);
%         quadset = {[],[],[],[]};
%         % assign points into four quadrants
%         series = 1:size(CCC,1);
%         series(k) = [];
%         for m = series
%             x = CCC(m,1);
%             y = CCC(m,2);
%             
%             % remove a target candidate if the lien segment goes across large part of
%             % darkness
% 
%             [~,zs] = getMaxZeroLength(CCC(k,:), CCC(m,:), BW, zeroDetectionWidth);
%             
%             if zs > thresZS
%                 continue;
%             end
%             
%             % put the valid candidates into the quadset
%             if y >= k1*x+b1 && y < k2*x+b1
%                 quadset{1} = [quadset{1},m];
%             elseif y > k1*x+b1 && y >= k2*x+b2
%                 quadset{2} = [quadset{2},m];
%             elseif y <= k1*x+b1 && y > k2*x+b2
%                 quadset{3} = [quadset{3},m];
%             elseif y < k1*x+b1 && y <= k2*x+b2
%                 quadset{4} = [quadset{4},m];
%             end
%         end
    if isempty(quadset)
        quadset = getQuadConnectionPointSet(CCC,BW,zeroDetectionWidth,thresZS,[1,-1]);
    end
    for k = 1:size(CCC,1)
        % find the closest point in each quadrant and connect them
        for m = 1:4
            if isempty(quadset{k,m})
                continue;
            end
            dist = sum(abs( repmat(CCC(k,:), [size(CCC(quadset{k,m},:),1),1]) - CCC(quadset{k,m},:)),2);
            [~,minpos] = min(dist);
            cTable = [cTable;[k,quadset{k,m}(minpos)]];
        end
    end
end