%% use $table$ variable to perform loop detection
load('dijk.mat');
loop = {};
loopPtr = 1;
for k = 1:size(table,1)
    tmpTable = table;
    target = tmpTable(k,:);
    tmpTable(k,:) = [];
    g = graph(tmpTable(:,1), tmpTable(:,2), ones(size(table,1)-1,1));
    [path,d] = shortestpath(g, target(1), target(2));
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
