function [y dy]=f3(x)

[m,n]=size(x);
x1=x(1,:);
x2=x(2,:);

b=[1 2]';
C=[12 3; 3 10];
y=repmat(1,1,n)+b'*x + 0.5*diag(x'*C*x)' + ...
    10*log(1+x1.^4).*sin(100*x1)+ ...
    10*log(1+x2.^4).*cos(100.*x2);

%z=reshape(z,length(x),length(x));

if nargout>1
% Gradient (computed symbolically by Matlab) is:
 dy=zeros(2,size(x,2));
 dy(1,:)= 40*x1.^3./(1+x1.^4).*sin(100*x1)+1000*log(1+x1.^4).*cos(100*x1);
 dy(2,:)= 40*x2.^3./(1+x2.^4).*cos(100*x2)-1000*log(1+x2.^4).*sin(100*x2);
 dy=dy+repmat(b,1,n)+C*x;
end

end