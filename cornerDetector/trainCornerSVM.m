clear
load lablledMultiClass.mat;
%% train the model
rng(10)
fprintf('training model ...\n');
% model = fitcsvm(data',label','KernelFunction','linear','KernelScale','auto', ...
%     'Standardize',false,'Cost',[0,1;2,0],'ScoreTransform','logit');
model = fitcecoc(data',label','learners','knn', 'cost', [0,1,1;10,0,10;100,100,0]);
%% run classification
fprintf('performing classification ...\n')
img = imread('3.jpg');
if length(size(img)) == 3
    img = rgb2gray(img);
end
img = img > 50;
newImg = zeros(size(img));
windowSize = 25;
step = 10;

M = size(img,1);
N = size(img,2);
imshow(img)
hold on
for m = windowSize+1:step:M
    for n = windowSize+1:step:N
        patch = imresize(img(m-windowSize:m,n-windowSize:n),[26,26]);
        [pred, scor] = predict(model, double(patch(:))');
        if pred == 1
%             imshow(imresize(patch,4));
%             pause
            plot(n-windowSize/2,m-windowSize/2,'r*');
        end
    end
end     
