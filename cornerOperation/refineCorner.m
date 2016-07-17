function nCCC = refineCorner(CCC, BW, width)
    CCC = int32(CCC);
    nCCC = zeros(size(CCC));
    for p = 1:size(CCC,1)
        block = BW(CCC(p,2)-width:CCC(p,2)+width, CCC(p,1)-width:CCC(p,1)+width);
        C = int32(myCorner(block));
%         C = int32(corner(block));
        if size(C,1) <= 1
            nCCC(p,2) = CCC(p,1);
            nCCC(p,1) = CCC(p,2);
            continue;
        end
        C = C + repmat([CCC(p,2)-width,CCC(p,1)-width], [size(C,1),1]);
        nCCC(p,:) = mean(C);
    end
    tmp = nCCC(:,2);
    nCCC(:,2) = nCCC(:,1);
    nCCC(:,1) = tmp;
end