function [f gradf]=f6(x)

if(size(x,1)~=2)
	error('Expecting 2 rows and received %i',size(x,1));
end

x1=x(1,:);
x2=x(2,:);

f=log(x1)-x2;

if nargout>1
numcols=size(x,2);
gradf=[1./x1;-ones(1,numcols)];
end

end
