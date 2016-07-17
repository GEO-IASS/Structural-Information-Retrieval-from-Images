function centroids = getLoopCentroid(CCC,loop)
    centroids = zeros(length(loop),2);
    for p = 1:length(loop)
        centroids(p,:) = mean( CCC(loop{p},:) );
    end
end