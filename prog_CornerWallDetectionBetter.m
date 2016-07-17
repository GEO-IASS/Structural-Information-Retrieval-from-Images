close all
clear
prog_setup
%% load image
tic;
fprintf('loading image...\n');
img = imread('.\1.jpg');
img = imresize(img, [NaN,450]);
M = size(img, 1); N = size(img, 2);

%% detect corners
fprintf('finding corner...\n')

[C,mimg] = myCorner(img);
tmp = C(:,1);
C(:,1) = C(:,2);
C(:,2) = tmp;

CCC = C;
for k = 1:3
    CCC = mergeWithNearest(CCC, 15);
end
fprintf('%d corners found.\n',size(CCC,1));
%% show the results
figure
imshow(img);

%% plot the corners
hold on;
plot(CCC(:,1),CCC(:,2),'r*');

%% construct the edges and visualize the result
fprintf('analyzing corners...\n');
ct = connectQuadNearest(CCC, img > 20, 5, 3, []);
nt = removeDuplicateItems(ct);
visualizeLineAndCorner(CCC,nt,zeros(size(img)));


%% find minimum loops using the connection table
fprintf('analyzing loops...\n');
loop = findLoopDFS(constructGraph(CCC,nt),CCC);
optLoopIdx = findLoopWithMinArea(loop,CCC,nt);

optLoop = {};
%% visualize the loops

for k = 1:length(optLoopIdx)
    optLoop = [optLoop,loop{optLoopIdx(k)}];
%     visualizeLineAndCorner(CCC,loopToCT(optLoop{k}),zeros(size(img)));
end

%% build the loop connectivity table
centroidLoop = getLoopCentroid(CCC,optLoop);
[lTable,~] = loopsToAdjacentTable(optLoop);

%% visualize the loops connection
visualizeLineAndCorner(centroidLoop,lTable,img);
plot(centroidLoop(:,1),centroidLoop(:,2),'r*');
fprintf('Program Finished in %f s.\n', toc);