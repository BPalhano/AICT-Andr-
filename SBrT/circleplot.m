function h = circleplot(x,y,r)
hold on
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
h = plot(xunit, yunit, "--", 'Color','black');
plot(y,x, "o", "Color", 'black');
axis equal
hold off

end 