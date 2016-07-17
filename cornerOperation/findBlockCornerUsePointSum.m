function [bC] = findBlockCornerUsePointSum(CCC,BW,width)
    bC = [];
    quads = zeros(size(CCC,1),4);
    CCC = int32(CCC);
    try
    for p = 1:size(CCC,1)
        block = BW(CCC(p,2)-width:CCC(p,2)+width, CCC(p,1)-width:CCC(p,1)+width);
        for q = 1:width
            quads(p,1) = quads(p,1) + sum(block(q, q:2*width+1-(q-1)-1));
            quads(p,2) = quads(p,2) + sum(block(q:2*width+1-(q-1)-1, 2*width+1-(q-1)));
            quads(p,3) = quads(p,3) + sum(block(2*width+1-(q-1), 2*width+1-(q-1):-1:q+1));
            quads(p,4) = quads(p,4) + sum(block(2*width+1-(q-1):-1:q+1, q));
        end
        
        tmp = [quads(p,:)',(1:4)'];
        tmp = sortrows(tmp);
        
        if ismember(abs(tmp(3,2) - tmp(4,2)),[1,3])
            bC = [bC,p];
        end
 
%         if length(find(quads) > 1) == 2 || sum(tmp(3:4)) - sum(tmp(1:2)) > thres 
%             bC = [bC, p];
%         end
    end
    catch ex
        fprintf(ex.message);
        fprintf('\n');
    end
end