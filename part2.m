  %% First function in part 2

  a=5;
  [x1,x2]=meshgrid(-a:0.01:a,-a:0.01:a);
  z=abs(x1-2)+abs(x2-2);
  mesh(x1,x2,z);
  contour(x1,x2,z,10);
  
  % constraint equations
  x2=-a:0.01:a;
  x1=x2.^2;
  hold on;
  plot(x1,x2,'k');

t=0:0.01:2*pi;
x1=cos(t);
x2=sin(t);

plot(x1,x2,'k');

% And now show the minimizer location
x=[1/sqrt(2);1/sqrt(2)]; %[0.6180;0.7862];
plot(x(1),x(2),'rx','markersize',12,'linewidth',1);
hold off;

% Minimizer as calculated by Matlab
%options=optimset('Diagnostics','on','Gradconstr','on');
%[y,fhat]=fmincon(@f4,[0.5;0],[],[],[],[],[],[],@f4con,options)

%----------------------------
%% Second function in part 2
a=2;
[x1,x2]=meshgrid(-a:0.01:a,-a:0.01:a);
z=-x1.*x2;
contour(x1,x2,z,20);

x2=-a:0.01:a;

% First inequality contraints
x1=-x2.^2+1;
hold on;
plot(x1,x2);

% Second set of inequality constraints
x1=-x2;
plot(x1,x2);

% minimizer location
x=[0.6667;0.5774];
plot(x(1),x(2),'rx','markersize',12,'linewidth',1);
hold off;

%figure; mesh(x1,x2,z) % Does not look nice.

% Using Matlab optimization toolbox to find minimum
%[y,fhat]=fmincon(@f5,[-4;1],[],[],[],[],[],[],@f5con)

%----------------------------------
%% Third function in part 2
a=4;
[x1,x2]=meshgrid(0.01:0.01:a,-a:0.01:a);

z=log(x1)-x2;
contour(x1,x2,z,20)
% mesh(x1,x2,z) % Does not look nice

% Inequality constraint
t=-a:0.01:a;
x1=ones(1,length(t));
hold on;
plot(x1,t);

% Equality constraints
t=0:0.01:2*pi;
x1=2*cos(t);
x2=2*sin(t);
plot(x1,x2);

% minimizer location
x=[1.000; 1.7321];
plot(x(1),x(2),'rx','markersize',12,'linewidth',1);
hold off;

%{ 
% Minimization using to Matlab optimization toolbox
options=optimset('Diagnostics','on','Gradconstr','on');
[y,fhat]=fmincon(@f6,[-4;1],[],[],[],[],[],[],@f6con,options)
%}

%---------------------------------------
%% Scratch region (for prototyping, testing... etc)
%options=optimset('Diagnostics','on','Gradconstr','on');