function [c,ceq]=fcontest(x)
% Test constraint function. (May be infeasible constraints)

if(size(x,1)~=2)
	error('Expecting 2 rows, received %i',size(x,1));
end

x1=x(1,:); x2=x(2,:);

ceq=[x1.^2+x2.^2-1; x1.*x2; x1-x2];
c=[x2.^2 - x1; x1-x2.^2; x1; x2];

end
