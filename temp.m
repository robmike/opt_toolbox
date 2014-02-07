a=.2;
[x,y]=meshgrid(-.1:.05:.05,-.25:.05:-0.05);
C=[12 3; 3 10];
w=[x(:) y(:)]';
z=repmat(1,1,length(x(:)))+[1 2]*w + 0.5*diag(w'*C*w)' + (10*log(1+x(:).^4).*sin(100*x(:)))'+10*(log(1+y(:).^4).*cos(100.*y(:)))';

z=reshape(z,length(x),length(x));

%pcolor(x,y,z)
[C,h]=contour(x,y,z,20);
