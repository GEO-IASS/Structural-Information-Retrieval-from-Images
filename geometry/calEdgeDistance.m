function weights = calEdgeDistance(table, CCC)
    weights = zeros(size(table,1),1);
    for k = 1:size(table,1)
        weights(k) = sum(abs(CCC(table(k,1),:) - CCC(table(k,2),:)));
    end
end