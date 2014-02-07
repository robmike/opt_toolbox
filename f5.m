function [f gradf]=f5(x)

if(size(x,1)~=2)
	error('Expecting 2 rows and received %i',size(x,1));
end

x1=x(1,:);
x2=x(2,:);

f=-x1.*x2;

if nargout>1
gradf=[-x2;-x1];
end

end
