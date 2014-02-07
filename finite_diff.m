function y=finite_diff(f,x,h);
% Computes the first order forward finite differences in each co-ordinate 
% with x2-x1=h (evaluated at x)
% Numerical approximation to the gradient at x.
% f is function handle that returns
% a row vector with ith entry corresponding to f(xi) where xi is
% the ith column of x

% Vectorized
	
	n=length(x);
	
	% Make a matrix with each column composed of the vector x and then
	% subtract h*I
	% f(x) will return a row vector, ith entry corresponding to function 
	% evaluated at ith columnn of x
	% So ith entry of f(xh)-f(x) is just f(z+hi)-f(z) where z is the ith
	% column of z and hi has hi(i)=1 and hi(j)=0 for i~=j
	
	xh=repmat(x,1,n)+diag(repmat(h,1,n));
	y=(f(xh)-f(x))/h;
	y=y';
end
