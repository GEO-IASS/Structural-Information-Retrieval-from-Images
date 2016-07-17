function ntable = removeDuplicateItems(table)
    exitFlag = 0;
    ntable = [];
    while ~exitFlag
        exitFlag = 1;
        while ~isempty(table)
            tmp = table(1,:);
            idx = ismember(table(2:end,:), tmp, 'rows');
            if sum(idx(:)) ~= 0
                idx = find(idx) + 1;
                table(idx,:) = [];
                exitFlag = 0;
            end
            idx = ismember([table(2:end,2),table(2:end,1)], tmp, 'rows');
            if sum(idx(:)) ~= 0
                idx = find(idx) + 1;
                table(idx,:) = [];
                exitFlag = 0;
            end
            ntable = [ntable;table(1,:)];
            table(1,:) = [];
        end
    end
end