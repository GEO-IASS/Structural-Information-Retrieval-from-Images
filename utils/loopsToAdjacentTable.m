function [lTable, commonVertex] = loopsToAdjacentTable(loop)
    lTable = [];
    commonVertex = {};
    for p = 1:length(loop)
        for q = p+1:length(loop)
            cv = intersect(loop{p},loop{q});
            if length(cv) >= 2
                lTable = [lTable;[p,q]];
                commonVertex = [commonVertex,cv];
            end
        end
    end
end