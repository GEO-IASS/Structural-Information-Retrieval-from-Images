clear
data = [];
label = [];
step = 10;
windowSize = 25;
dataPtr = 1;

img = imread('20.jpg');
if length(size(img)) == 3
    img = rgb2gray(img);
end
M = size(img,1);
N = size(img,2);

for m = windowSize+1:step:M
    for n = windowSize+1:step:N
        patch = img(m-windowSize:m,n-windowSize:n);
        if sum(sum(patch > 50)) == (windowSize+1)*(windowSize+1)
            continue;
        end

        imshow(imresize(patch,4));
        str = sprintf('input class for #%d: ',dataPtr);
        patchLabel = input(str);
        data(:,dataPtr) = patch(:);
        label(dataPtr) = patchLabel;
        dataPtr = dataPtr + 1;
    end
end

data = [data, zeros(676,100)];
label = [label, zeros(1,100)];

idx = randperm(size(data,2));
data = data(:,idx);
label = label(idx);

save labelledPatchData.mat