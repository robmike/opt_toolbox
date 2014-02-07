w=linspace(0,2*pi,100);
for i=1:length(w)
   z(i)=conetest([1 0]',[cos(w(i)) sin(w(i))]',pi/2);
end
plot(w/pi*180,z)
%%
[x,y]=meshgrid(-4:.01:4,-4:.01:4);

z=-sqrt((x.^2+1).*(2*y.^2+1))./(x.^2+y.^2+0.5);
contour(x,y,z,20);
figure;
mesh(x,y,z)
%%
[x,y]=meshgrid(-1:.05:1,-1:.05:1);
C=[12 3; 3 10];
w=[x(:) y(:)]';
z=repmat(1,1,length(x(:)))+[1 2]*w + 0.5*diag(w'*C*w)' + (10*log(1+x(:).^4).*sin(100*x(:)))'+10*(log(1+y(:).^4).*cos(100.*y(:)))';

z=reshape(z,length(x),length(x));

%pcolor(x,y,z)
[C,h]=contour(x,y,z,20);
figure;
mesh(x,y,z);

shading interp
%[C,h]=contour(x,y,z);

%% Progression figures for example (B) (overlayed)
[x,y]=meshgrid(-4:.01:4,-4:.01:4);
z=-sqrt((x.^2+1).*(2*y.^2+1))./(x.^2+y.^2+0.5);
contour(x,y,z,10);
hold on;

scale=0;
x0=[3,-1]';
[xhat,fhat,iter,gradvec,xvec]=steepd(@f2,x0,'gradmode','analyt');
d=diff(xvec,1,2);
H(1)=quiver(xvec(1,1:end-1),xvec(2,1:end-1),d(1,:),d(2,:),0,'linewidth',1);

[xhat,fhat,iter,gradvec,xvec]=conjgrad(@f2,x0,'gradmode','analyt');
d=diff(xvec,1,2);
H(2)=quiver(xvec(1,1:end-1),xvec(2,1:end-1),d(1,:),d(2,:),0,'linewidth',1);

[xhat,fhat,iter,gradvec,xvec]=secant(@f2,x0,'gradmode','analyt');
d=diff(xvec,1,2);
H(3)=quiver(xvec(1,1:end-1),xvec(2,1:end-1),d(1,:),d(2,:),0,'m','linewidth',1);

% Minimizer location
plot(0,0,'rx','markersize',6,'linewidth',1)

% Uncomment following code if we also want to show gradient vectors
%[f,df]=f2(xvec);
%quiver(xvec(1,:),xvec(2,:),-df(1,:),-df(2,:),0);
hold off;

legend(H,'Steepest descent','Conjugate Gradient','Secant')

%% Progression figures for example (B) (subplots)
figure

[x,y]=meshgrid(-4:.01:4,-4:.01:4);
scale=0;
x0=[3,-1]';

subplot(2,2,1);

z=-sqrt((x.^2+1).*(2*y.^2+1))./(x.^2+y.^2+0.5);
contour(x,y,z,10);
hold on;
[xhat,fhat,iter,gradvec,xvec]=steepd(@f2,x0,'gradmode','analyt');
d=diff(xvec,1,2);
H(1)=quiver(xvec(1,1:end-1),xvec(2,1:end-1),d(1,:),d(2,:),0,'linewidth',1);
plot(0,0,'rx','markersize',6,'linewidth',1); %minimizer
xlabel('(a)');

subplot(2,2,2);
z=-sqrt((x.^2+1).*(2*y.^2+1))./(x.^2+y.^2+0.5);
contour(x,y,z,10);
hold on;
[xhat,fhat,iter,gradvec,xvec]=conjgrad(@f2,x0,'gradmode','analyt');
d=diff(xvec,1,2);
H(2)=quiver(xvec(1,1:end-1),xvec(2,1:end-1),d(1,:),d(2,:),0,'linewidth',1);
plot(0,0,'rx','markersize',6,'linewidth',1); % minimizer
xlabel('(b)');

subplot(2,2,3);
z=-sqrt((x.^2+1).*(2*y.^2+1))./(x.^2+y.^2+0.5);
contour(x,y,z,10);
hold on;
[xhat,fhat,iter,gradvec,xvec]=secant(@f2,x0,'gradmode','analyt');
d=diff(xvec,1,2);
H(3)=quiver(xvec(1,1:end-1),xvec(2,1:end-1),d(1,:),d(2,:),0,'linewidth',1);
plot(0,0,'rx','markersize',6,'linewidth',1); % minimizer
xlabel('(c)');

hold off;

%% Progression figures for example (B) (subplots w/ overlay in one subplot)

[x,y]=meshgrid(-4:.01:4,-4:.01:4);
scale=0;
x0=[3,-1]';

figure
subplot(2,2,1);

z=-sqrt((x.^2+1).*(2*y.^2+1))./(x.^2+y.^2+0.5);
contour(x,y,z,10);
hold on;
[xhat,fhat,iter,gradvec,xvec]=steepd(@f2,x0,'gradmode','analyt');
d=diff(xvec,1,2);
H(1)=quiver(xvec(1,1:end-1),xvec(2,1:end-1),d(1,:),d(2,:),0,'b','linewidth',1);
plot(0,0,'rx','markersize',6,'linewidth',1); %minimizer
xlabel('(a)');

subplot(2,2,2);
z=-sqrt((x.^2+1).*(2*y.^2+1))./(x.^2+y.^2+0.5);
contour(x,y,z,10);
hold on;
[xhat,fhat,iter,gradvec,xvec]=conjgrad(@f2,x0,'gradmode','analyt');
d=diff(xvec,1,2);
H(2)=quiver(xvec(1,1:end-1),xvec(2,1:end-1),d(1,:),d(2,:),0,'k','linewidth',1);
plot(0,0,'rx','markersize',6,'linewidth',1); % minimizer
xlabel('(b)');

subplot(2,2,3);
z=-sqrt((x.^2+1).*(2*y.^2+1))./(x.^2+y.^2+0.5);
contour(x,y,z,10);
hold on;
[xhat,fhat,iter,gradvec,xvec]=secant(@f2,x0,'gradmode','analyt');
d=diff(xvec,1,2);
H(3)=quiver(xvec(1,1:end-1),xvec(2,1:end-1),d(1,:),d(2,:),0,'m','linewidth',1);
plot(0,0,'rx','markersize',6,'linewidth',1); % minimizer
xlabel('(c)');

% overlayed plot
subplot(2,2,4);
contour(x,y,z,10);
hold on;

scale=0;
x0=[3,-1]';
[xhat,fhat,iter,gradvec,xvec]=steepd(@f2,x0,'gradmode','analyt');
d=diff(xvec,1,2);
H(1)=quiver(xvec(1,1:end-1),xvec(2,1:end-1),d(1,:),d(2,:),0,'b','linewidth',1);

[xhat,fhat,iter,gradvec,xvec]=conjgrad(@f2,x0,'gradmode','analyt');
d=diff(xvec,1,2);
H(2)=quiver(xvec(1,1:end-1),xvec(2,1:end-1),d(1,:),d(2,:),0,'k','linewidth',1);

[xhat,fhat,iter,gradvec,xvec]=secant(@f2,x0,'gradmode','analyt');
d=diff(xvec,1,2);
H(3)=quiver(xvec(1,1:end-1),xvec(2,1:end-1),d(1,:),d(2,:),0,'m','linewidth',1);

% Minimizer location
plot(0,0,'rx','markersize',6,'linewidth',1)

% Uncomment following code if we also want to show gradient vectors
%[f,df]=f2(xvec);
%quiver(xvec(1,:),xvec(2,:),-df(1,:),-df(2,:),0);
hold off;

legend(H,'Steepest descent','Conjugate Gradient','Secant')
xlabel('(d)');


hold off;

