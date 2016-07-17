img = rgb2gray(im2double(imread('1.jpg')));
[map r c] = susanCorner(img);
figure,imshow(img),hold on
plot(c,r,'r*')