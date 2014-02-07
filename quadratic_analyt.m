function [f,df]=quadratic_analyt(x)
% Can take a matrix argument.
	[m,n]=size(x);
	a=-5; b=[-2 1]';
	L=[1 0; 4 2];
	C=L*L';
	f=repmat(a,1,n)+b'*x+0.5*diag(x'*C*x)';
	df=repmat(b,1,n)+C*x;
end
