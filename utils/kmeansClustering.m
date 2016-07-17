%% perform k-means on data
% the array *data* should be aligned as numOfItems * ItemDim

function [classCenter, classMember] = kmeansClustering(data, numOfClasses, maxIter)
    
    dataSize = size(data);
    dataDim = length(size(data));
    
    distance = zeros(dataSize(1), numOfClasses);
    classCenter = rand(numOfClasses, dataDim) * max(data(:));
    
    % begin K-means clustering
    for i = 1:maxIter
        % calculate distance
        for k = 1:numOfClasses
            temp = repmat(classCenter(k,:), [dataSize(1),1]);
            distance(:,k) = sqrt(sum((temp - data).^2, 2));
        end
        % find the closest neighbour
        [~,minIdx] = min(distance,[],2);
        % update center position
        for k = 1:numOfClasses
            classPointIdx = find(minIdx == k);
            if length(classPointIdx) == 0
                break;
            end
            classCenter(k,:) = mean(data(classPointIdx,:), 1);
        end
    end
    classMember = minIdx;
end