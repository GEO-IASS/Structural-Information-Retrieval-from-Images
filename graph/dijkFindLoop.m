function loop = dijkFindLoop(table,CCC,w)
    loop = {};
    loopPtr = 1;
    for k = 1:size(table,1)
        tmpTable = table;
        
        if isempty(w)
            weights = calEdgeDistance(tmpTable, CCC);
        else
            weights = w;
        end
        
        weights(k) = Inf;
        
        g = graph(tmpTable(:,1), tmpTable(:,2), weights);

        [path,d] = shortestpath(g, tmpTable(k,1), tmpTable(k,2));
        
        % eliminate loop with only 3 corners
        if length(path) <= 3
            continue;
        end
        % discard the result if a loop with exactly same elements already
        % exists
        if ~isempty(path)
            if loopPtr >= 2
                flag = 0;
                for p = 1:length(loop)
                    if length(path) == length(loop{p}) && ...
                            sum(sort(path) == sort(loop{p})) == length(path)
                        flag = 1;
                        break;
                    end
                end
                if flag
                    continue;
                end
            end
            loop{loopPtr} = path;
            loopPtr = loopPtr + 1;
        end
    end
end