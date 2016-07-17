%% Get the area of a polygon based on the known vertex list.
% Usage:
%       area = getPolygonArea(vertexList);
% Input argument(s):
%   vertexList: a list of size (M,2), each row of it being the coordinate
%   of a vertex of the polygon. These vertices should be orderred clockwise
%   or counterclockwise.
% Output argument(s):
%   area: the area of the polygon constructed by vertices described in
%   vertexList

function area = getPolygonArea(vertexList)
    area = 0;
    for k = 1:size(vertexList,1)-1
        area = area + 0.5 * det([vertexList(k,:);vertexList(k+1,:)]);
    end
    area = area + 0.5 * det([vertexList(size(vertexList,1),:);vertexList(1,:)]);
    area = abs(area);
end