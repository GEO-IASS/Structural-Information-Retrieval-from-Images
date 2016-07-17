function [notVisited, visited] = getDFSNeighbour(graph, nodeID, visitedID)
     id = find(graph(nodeID, :));
     visited = [];
     notVisited = [];
     
     for k = 1:length(id)
         if(visitedID(id(k)))
             visited = [visited, id(k)];
         else
             notVisited = [notVisited, id(k)];
         end
     end
end