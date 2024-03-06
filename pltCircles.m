function pltCircles(r,x,y)
    xc = x;
    yc = y;
    theta = linspace(0,2*pi);
    x = r*cos(theta) + xc;
    y = r*sin(theta) + yc;
    hold on;
    plot(x,y);
    hold on;
    axis equal
end
