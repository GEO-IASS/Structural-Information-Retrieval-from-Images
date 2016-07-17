%% find minimum loop based on the area of the loop

function newloopIdx = findLoopWithMinArea(loop,CCC,cTable)
    area = ones(length(loop),1);
    for p = 1:length(loop)
        area(p) = getPolygonArea(CCC(loop{p},:));
    end
    area = sortrows([area,(1:length(loop))']);
    loopCdt = [];
    for p = 1:size(cTable,1)
        for q = 1:size(area,1)
            if ismember(cTable(p,1),loop{area(q,2)}) && ismember(cTable(p,2),loop{area(q,2)})
                loopCdt = [loopCdt,area(q,2)];
                break;
            end
        end
    end
    newloopIdx = unique(loopCdt);
end