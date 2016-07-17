%% Use only corner information, force straight lines using vrt & hrz distances
function [lineTable, cTable] = connectUseVtHzDist(CCC, thresholdHz, thresholdVt)
    lineTable = [];
    cTable = [];
    p = 1;
    for k = 1:size(CCC,1)
        [cdtHz,~] = find(abs(CCC(k,1) - CCC(:,1)) < thresholdHz & abs(CCC(k,1) - CCC(:,1)) > 0);
        if ~isempty(cdtHz)
            distHzVt = abs(CCC(cdtHz,2) - CCC(k,2));
            [~,findHz] = min(distHzVt);
            lineTable(p,1:2) = CCC(k,:);
            lineTable(p,3:4) = CCC(cdtHz(findHz),:);
            cTable(p,1) = k;
            cTable(p,2) = cdtHz(findHz);
            p = p+1;
        end

        [cdtVt,~] = find(abs(CCC(k,2) - CCC(:,2)) < thresholdVt & abs(CCC(k,2) - CCC(:,2)) > 0);
        if ~isempty(cdtVt)
            distVtHz = abs(CCC(cdtVt,1) - CCC(k,1));
            [~,findVt] = min(distVtHz);
            lineTable(p,1:2) = CCC(k,:);
            lineTable(p,3:4) = CCC(cdtVt(findVt),:);
            cTable(p,1) = k;
            cTable(p,2) = cdtVt(findVt);
            p = p+1;
        end
    end
end