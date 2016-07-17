%% Find all loops in a graph, including chord cycles and chordless cycles
% Input argument:
%   cGraph: adjacent matrix of vertices
%   CCC: an M*2 array containing M coordinates of vertices
% Output argument:
%   loop: a cell containing loops. Each cell is a list of indices of
%   vertices


function loop = findLoopDFS(cGraph, CCC)
    %% find loops for refinement
    % loops found here may not be simple loops, so refinement is needed
    % afterwards
    [stack,ptr] = stackInit();
    visited = zeros(1,size(CCC,1));
    visitedOnce = zeros(1,size(CCC,1));
    pathPtr = 1;

    loopPtr = 1;
    loop{1} = [];

    toVisit = {};
    tvPtr = 0;

    while sum(~visitedOnce) ~= 0
        idx = find(visitedOnce == 0);
        startPt = idx(1);
        visited(startPt) = 1;
        visitedOnce(startPt) = 1;
        [stack, ptr] = stackPush(stack, ptr, startPt);
        crtPt = stackPeek(stack, ptr);
        path{pathPtr} = crtPt;

        while ~stackEmpty(ptr)
            crtPt = stackPeek(stack, ptr);
            angle = [];

            [newNb,oldNb] = getDFSNeighbour(cGraph,crtPt,visited);

            if tvPtr == ptr
                newNb = toVisit{tvPtr};
            else
                tvPtr = tvPtr + 1;
            end

            if ~isempty(oldNb)
                for k = 1:length(oldNb)
                    tempPath = [path{pathPtr}, oldNb(k)];
                    idx = find(tempPath == oldNb(k));
                    if length(idx) == 2 && idx(2) ~= idx(1) + 2
                        loop{loopPtr} = tempPath(idx(1):idx(2)-1);
                        loopPtr = loopPtr + 1;
                    end
                end
            end

            if ~isempty(newNb)
                for p = 1:length(newNb)
                    angle(p) = getAngle(CCC(crtPt,:),CCC(newNb(p),:));
                end

                angles = [angle',newNb'];
                angles = sortrows(angles);

                toVisit{tvPtr} = (angles(2:end,2))';

                nextVisit = angles(1,2);
                visited(nextVisit) = 1;
                visitedOnce(nextVisit) = 1;
                path{pathPtr} = [path{pathPtr}, nextVisit];
                [stack,ptr] = stackPush(stack,ptr,nextVisit);
            else
                pathPtr = pathPtr + 1;
                if(length(path{pathPtr-1}) == 1)
                else
                    path{pathPtr} = path{pathPtr-1}(1:length(path{pathPtr-1})-1);
                end
                [stack,ptr,val] = stackPop(stack,ptr);
                visited(val) = 0;
                tvPtr = tvPtr - 1;
            end
%             stackPrint(stack,ptr);
        end
    end

    % remove duplicated loops
    for p = 1:length(loop)
        for q = p+1:length(loop)
            if length(loop{p}) == length(loop{q}) && ...
                sum(sort(loop{p}) == sort(loop{q})) == length(loop{p})
                loop{q} = [];
            end
        end
    end
    loop = loop(~cellfun('isempty',loop));
end