%% Use Hough Transform to find lines in a BW image
% Input Arguments:
% numLines: the maximum number of lines to be found, typical 25
% minLength: the minimum length for a valid line, typical 20~40
% thresFactor: the minimum value for a peak to be considered as a line, 
% typical 0.1~0.3

function [CCC,cTable] = houghTransLineDetection(BW, numLines, minLength, thresFactor)
    I = BW;
    CCC = [];
    cTable = [];
    lPtr = 1;
    [H,theta,rho] = hough(BW,'RhoResolution',1);
    P = houghpeaks(H,numLines,'threshold',ceil(thresFactor*max(H(:))));
    lines = houghlines(BW,theta,rho,P,'MinLength',minLength);
    for k = 1:length(lines)
        CCC(lPtr,:) = lines(k).point1;
        CCC(lPtr+1,:) = lines(k).point2;
        cTable = [cTable;[lPtr, lPtr+1]];
        lPtr = lPtr + 2;
    end
end

