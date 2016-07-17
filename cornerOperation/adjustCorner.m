%% adjust corner points with respect to lineTable

function [newCCC, newLineTable] = adjustCorner(lineTable, cTable, CCC, threshold)
    
    for p = 1:size(CCC,1)
        for q = 1:size(lineTable,1)
            [dist, flag] = pointToLineDistance([lineTable(q,1:2);lineTable(q,3:4)], CCC(p,:));
            vectA = lineTable(q,3:4) - lineTable(q,1:2);
            vectB = CCC(p,:) - lineTable(q, 1:2);
            
            if flag && abs(dist) < threshold && dist ~= 0
                newCCC(p, :) = dot(vectA,vectB) / norm(vectA) * vectA / norm(vectA) + lineTable(q,1:2);
                if newCCC(p,1) == 0
                    dot(vectA,vectB)
                end
                break;
                mask1 = cTable(:,1) == p;
                mask2 = cTable(:,2) == p;
                mask = [repmat(mask1,[size(CCC,1),2]),repmat(mask2,[size(CCC,1),2])];
                new = repmat(newCCC(p,:), [size(CCC,1),2]);

                lineTable(mask) = new(mask);
            else
                newCCC(p,:) = CCC(p,:);
            end
        end
    end
end