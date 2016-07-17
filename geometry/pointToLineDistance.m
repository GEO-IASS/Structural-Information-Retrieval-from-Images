%% calculate the distance between a point and a line
% flag: whether the point lies inside the segment or lies on the
% extension of the segment

function [dist, flag, theta] = pointToLineDistance(vectorEnds, point)

    vect1 = vectorEnds(2,:) - vectorEnds(1,:);
    vect2 = point - vectorEnds(1,:);
    dist1 = dot(vect1, vect2) / norm(vect1);
    dist2 = norm(point - vectorEnds(1,:));
    
    dist = sqrt(dist2^2-dist1^2);
    flag = dist1 > 0;
    theta = dist1 / norm(vect2);
end