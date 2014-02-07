function [c,ceq,gradc,gradceq]=f6con(x)

if(size(x,1)~=2)
	error('Expecting 2 rows, received %i',size(x,1));
end

x1=x(1,:); 
x2=x(2,:);

c = -(x1-1);
ceq = x1.^2+x2.^2-4;

if nargout>2
numcols=size(x,2);

gradc = [ -ones(1,numcols); zeros(1,numcols)];
gradceq = [2*x1; 2*x2];
end

end
