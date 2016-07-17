function cGraph = constructGraph(CCC, cTable)
    cGraph = zeros([size(CCC,1), size(CCC,1)]);
    for k = 1:size(cTable,1)
        cGraph(cTable(k,1), cTable(k,2)) = 1;
        cGraph(cTable(k,2), cTable(k,1)) = 1;
    end
end