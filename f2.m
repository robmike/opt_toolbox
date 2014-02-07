function [w dw]=f2(z)
% Returns function value and gradient at z for second example problem
% z can be an arbitrary (2xN) matrix. Function (and gradient) are evaluated for
% each column of z and return in a row vector (ith row of w or dw corresponds 
% to ith column of z).
% Does no error checking (you have to make sure z has 2 rows).
    
    x1=z(1,:);
    x2=z(2,:);

    w=-sqrt((x1.^2+1).*(2*x2.^2+1))./(x1.^2+x2.^2+0.5);
    
    if nargout>1
     dw=zeros(2,size(z,2));
    % Gradient (computed symbolically by Matlab) is:
     dw(1,:)=2*x1.*(4*x2.^2.*x1.^2-4*x2.^4+4*x2.^2+2*x1.^2+3)./...
     ((x1.^2+1).*(2*x2.^2+1)).^(1/2)./(2*x1.^2+2*x2.^2+1).^2;
    
     dw(2,:)= -4*x2.*(2*x1.^4-2*x1.^2.*x2.^2+x1.^2-2*x2.^2-1)./ ...
     ((x1.^2+1).*(2*x2.^2+1)).^(1/2)./(2.*x1.^2+2.*x2.^2+1).^2;
    end
    
    % error(nargchk(1, 3, nargin, 'struct'))
    % MSG = NARGCHK(LOW,HIGH,N)
    
end