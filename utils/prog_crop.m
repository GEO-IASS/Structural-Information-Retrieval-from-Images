
imshow(img);
while true
    imcrop;
    c = getimage(gcf);
    c = imresize(c,[25,25]);
    crop = [crop,c(:)];
    close;
end