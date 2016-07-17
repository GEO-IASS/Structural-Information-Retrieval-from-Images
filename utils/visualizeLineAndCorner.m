function visualizeLineAndCorner(CCC, cTable, img)
    figure
    imshow(img)
    hold on
    for k = 1:size(cTable,1)
        point1 = CCC(cTable(k,1),:);
        point2 = CCC(cTable(k,2),:);
        plot(point1(1), point1(2), 'r*');
        plot(point2(1), point2(2), 'r*');
        plot([point1(1);point2(1)], [point1(2); point2(2)], 'LineWidth',1,'Color', 'yellow');
    end

end