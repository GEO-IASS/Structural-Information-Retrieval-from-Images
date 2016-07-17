function visualizeCorners(CCC, img, aprColorStr)
    figure
    imshow(img);

    hold on
    plot(CCC(:,1),CCC(:,2),aprColorStr);
end