function response= bmfundamped(x)
x=exp(x);
kp=x(1);ks=x(2);mp=x(3);ms=x(4);zp=x(5);zs=x(6);fs=x(7);s0=100;
wp=sqrt(kp/mp); ws=sqrt(ks/ms);wa=(wp+ws)/2; za=(zp+zs)/2; gamma=ms/mp; tetta=(wp-ws)/wa;
response=-(fs)+3*ks*( ((pi*s0)/(4*zs*ws^3)) * ((za*zs)/(zp*zs*(4*za^2+tetta^2)+gamma*za^2)) * (((zp*wp^3+zs*ws^3)*wp)/(4*za*wa^4)) )^0.5;