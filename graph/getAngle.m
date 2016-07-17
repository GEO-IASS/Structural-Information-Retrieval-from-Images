function angle = getAngle(orient, point)
    vect1 = point - orient;
    vect2 = [1,0];
    angle = acos(dot(vect1,vect2)/norm(vect1)/norm(vect2));
    if vect1(2) < 0
        angle = angle + pi;
    end
end