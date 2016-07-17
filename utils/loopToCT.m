function cTable = loopToCT(loop)
    loopList = [loop, loop(1)];
    cTable = [];
    for k = 1:length(loopList)-1
        cTable = [cTable; [loopList(k),loopList(k+1)]];
    end
end