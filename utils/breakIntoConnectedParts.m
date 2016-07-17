function [nmscClass] = breakIntoConnectedParts(mscClass)
    nmscClass = [];
    classCount = max(mscClass(:,3));
    newClassPtr = 0;
    for p = 1:classCount
        subClassTable = mscClass(mscClass(:,3) == p, 1:3);
        newSubClassTable = bk_wanderInClass(subClassTable);
        newSubClassTable(:,3) = newSubClassTable(:,3) + newClassPtr;
        newClassPtr = max(newSubClassTable(:,3));
        nmscClass = [nmscClass; newSubClassTable];
    end
end

function newSubClassTable = bk_wanderInClass(subClassTable)
    global bk_newSubTable;
    global bk_subTable;
    global bk_visited;
    
    bk_newSubTable = zeros(size(subClassTable));
    bk_subTable = subClassTable;
    bk_visited = zeros(1,size(subClassTable,1));
    subClassPtr = 1;
    
    while sum(bk_visited) ~= length(bk_visited)
        startIdx = find(bk_visited == 0);
        p = subClassTable(startIdx(1),1);
        q = subClassTable(startIdx(1),2);
        
        bk_wanderInClass_walker(p,q,subClassPtr);
        subClassPtr = subClassPtr + 1;
    end
    
    newSubClassTable = bk_newSubTable;
end

function bk_wanderInClass_walker(p,q,classPtr)
    global bk_newSubTable;
    global bk_subTable;
    global bk_visited;
    
    idx = find(bk_subTable(:,1) == p & bk_subTable(:,2) == q);
    
    if isempty(idx) || bk_visited(idx)
        return;
    end
    bk_newSubTable(idx,:) = [p,q,classPtr];
    bk_visited(idx) = 1;
    
    bk_wanderInClass_walker(p+1,q,classPtr)
    bk_wanderInClass_walker(p-1,q,classPtr)
    bk_wanderInClass_walker(p,q+1,classPtr)
    bk_wanderInClass_walker(p,q-1,classPtr)
end