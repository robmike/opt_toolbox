function [y grady]=f4(x)
	if(size(x,1)~=2)
		error('Two rows expected, received %i',size(x,1));
	end
	x1=x(1,:);
	x2=x(2,:);
	y=abs(x1-2)+abs(x2-2);
	%y=(x-[2;2])'*eye(2)*(x-[2;2]); % Quadratic for debugging/testing

% Minimum to the constrained problem is 2.5858 at [1/sqrt(2);1/sqrt(2)]

if nargout>1
    numcols=size(x,2);
    grady=zeros(2,numcols); % Define gradient of abs(x) at x=0 as 0
    
    grady(1,x1>2)=1;
    grady(1,x1<2)=-1;
    
    grady(2,x2>2)=1;
    grady(2,x2<2)=-1;
    
end