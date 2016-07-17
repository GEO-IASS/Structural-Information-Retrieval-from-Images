%% Corners with distance smaller than thres from each other will be merged

function C = mergeWithNearest(P,thres)
    C = [];
    p = P;

    while size(p,1) > 1

        distance = sum( abs( p - repmat(p(1,:), [size(p,1), 1]) ), 2);
        distance = [distance, (1:size(p,1))'];
        distance = sortrows(distance);

        dist = distance(2,1);
        pos = distance(2,2);
        
        if dist < thres
            C = [C; mean([p(1,:); p(pos,:)])];
            p(pos,:) = [];
        else
            C = [C; p(1,:)];
        end
        p(1,:) = [];
    end
    if size(p,1) == 1
        C = [C; p(1,:)];
    end
end