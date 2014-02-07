function [xhat,fhat,iter,gradvec,xvec] = extpen(f,fcon,x0)
	
	maxiter=500;
	tol=1e-6;
	ctol=1e-4; % Tolerance to which constraints must be satisfied
	r=0.1; % Penalty number. 'sigma' in notes
	rmult=0.8; % Factor that r is multiplied by at each iteration
	
	if nargout>3
		iterguess=100; % Moderate overestimate of expected iterations
		gradvec=zeros(1,iterguess); % Norm of gradient at each iteration
		if nargout>4
		xvec=zeros(length(x0),iterguess); % Estimate of minimizer at each iteration
		end
	end

	if ~isa(f,'function_handle')
		error('Expected function handle but received %s', class(f))
	end
	if ~isa(fcon,'function_handle')
		error('Expected function handle but received %s', class(f))
	end
	
	x=x0;
	
	% Verify that x0 is indeed in the interior of the feasible set
	[cineq ceq]=fcon(x);
	if ~all(cineq<ctol)
			error('Initial point must be in the interior of the feasible set');
	end	
	numcon=size(cineq,1); % Number of constraints
	
	for i=0:maxiter
		
		if any(ceq~=0)
			error('Barrier function method only valid for inequality constraints');
		end
		
		% Stopping condition. Found on some website. (Validity=?)
		if numcon/r<tol
			break;
		end	
		
		% Create function handle for penalty function to be minmimized.
		fpen=@penalty_function;
		
		% Todo. This should be more abstract (any minimization algo.)
		[x,fhat,iter]=secant(fpen,x,'fd')
		
		r=r*rmult; % 'Grow' r for next iteration
		[cineq ceq]=fcon(x);
	end

	if(i==maxiter)
        disp('last value for x:')
        x
		error('Minimization did not converge');
	end	
	
	xhat=x;
	if nargout>1
	fhat=f(xhat);
	if nargout>2
	iter=i;
	if nargout>3
	xvec=xvec(:,1:iter);
	if nargout>4
	gradvec=gradvec(1:iter);
	end
	end
	end
	end
	
	
		% Nested function.
		function y=penalty_function(x)
		% Nested functions can be tricky, particularly variable scoping.
		% We try to avoid variable shadowing to minimize confusion.
		% Function accepts matrix arguments to conform with 
		% finite_diff.m
			[gineq geq]=fcon(x);
			gineq(gineq==0)=-ctol/10; % Avoid division by zero
			
			% First option for penalty function
			y=f(x)+r*sum(-1./gineq,1);
			
			% Alternative penalty function (try both out)
			%y=f(x)-r*sum(log(-gineq),1);
		end
		
end
