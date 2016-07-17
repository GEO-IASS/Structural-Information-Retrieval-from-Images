%% Connect two corners, searching for candidates from four directions
% Input Arguments:
%   CCC: an M*2 list containing coordinates of corners
%   BW: a binary image
%   thresZS: if there are thresZS or more zero pixels between two corners,
%   regard these two corners as disconnected
%   zeroDetectionWidth: controls the width of a straight line on which
%   connectivity of two coners are detected
% Output Arguments:
%   cTable: 

function cTable = connectQuadNearest(CCC, BW, thresZS, zeroDetectionWidth, quadset)
    cTable = [];

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