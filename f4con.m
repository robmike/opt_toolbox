function [c,ceq,gradc,gradceq]=f4con(x)

if(size(x,1)~=2)
	error('Expecting 2 rows, received %i',size(x,1));
end

x1=x(1,:); x2=x(2,:);

ceq=x1.^2+x2.^2-1;
c=x2.^2 - x1;

if nargout>2
    numcols=size(x,2);
    gradceq = [2*x1; 2*x2];
    gradc = [-ones(1,numcols);2*x2];
end

end
