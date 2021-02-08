function response= bmfun2D(x)
a=7; %Set parameter a here
response=((x(1).^2+4).*(x(2)-1))/20-cos(a*x(1)/2)-1.5;
