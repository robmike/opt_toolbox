function [c,ceq,gradc,gradceq]=f5con(x)

if(size(x,1)~=2)
	error('Expecting 2 rows, received %i',size(x,1));
end

x1=x(1,:); 
x2=x(2,:);

c(1,:)= -(-x1-x2.^2+1);
c(2,:)= -(x1+x2);


% There are no equality constraints so make a 'dummy' constraint that is always satisfied
ceq=0;

if nargout>2
n=size(x,2);
if(size(x,2)~=1)
	error('Input must be 1 column wide, received %i. (Limitation imposed by fmincon)',n);
end
gradc = [ [1;2*x2] [-1;-1] ];
gradceq = 0;
end


end
