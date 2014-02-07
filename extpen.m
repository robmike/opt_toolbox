function [xhat,fhat,extpeniter,unconiter,xvec] = extpen(f,fcon,x0,varargin)
% Constrained non-linear programming (optimization) using exterior penalty
% method.
% xhat = EXTPEN(f,fcon,x0,options)
% Function takes:
% f - function handle t be minimized which must conform to the 
% specifications given in minfunc.m (help minfunc if minfunc.m is in Matlab 
% path or current working directory).
% fcon - function which returns the equality and inequality constraint functions
% evaluated at a given point. These can be arbitrary constraint functions--they
% need not be linear. fcon must conform to specifications given in fcon.m
% (help fcon)
% x0 - An initial minimizer location
% options - An (optional) list of parameter-value pairs that specify 
% options. See minopts.m for more details.
% Also returns the obtained minimum fhat, the number of iterations of the
% exterior penalty (does not include iterations of unconstrained
% optimization), total number of iterations of unconstrained algorithms 
% and xvec is the minimizer estimate obtained at each iteration.
%
% It is likely that the unconstrained algorithm will not converge for some
% iterations. This produces warning messages. To turn these messages off
% you can use warning('off','UNCONOPT:noConverge') before calling the
% unconstrained minimization function (extpen).
%
% Method is not numerically robust and may result in problems in some cases.

    
    params=initparams();
    if ~isempty(varargin)
    params=setparams(params,varargin{:});
    end
    
    verbose=strcmp(params.verbose,'on');
    maxiter=params.maxconiter;
    ctol=params.contol;
    r=params.penaltynumberstart;
    rmult=params.penaltynumbermult;
    unconalgo=params.unconalgo;
    

	
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
	
	% Verify that x0 is indeed in the exterior of the feasible set
	[cineq ceq]=fcon(x0);
	if all(abs(ceq)<ctol) && all(cineq<ctol)
			error('Initial point must be in the exterior of the feasible set');
    end	
	
    
    unconiter=0;
	x=x0;
	for i=0:maxiter
		
		[cineq ceq]=fcon(x);
		
		% Stopping condition. Note that stopping condition is 
		% elementwise and not with respect to the norm
		if all(abs(ceq)<ctol) && all(cineq<ctol)
			break;
		end	
		
		% Create function handle for penalty function to be minmimized.
		fpen=@(x) penalty_function(f,fcon,x,r);
		
		[x,fhat,iter]=fminimize(fpen,x,varargin{:});
        %[x,fhat,iter]=secant(fpen,x,varargin{:});
        unconiter=unconiter+iter;
        
        if(verbose)
		x=x % For debugging.
        end
        
        % Store history of xvec
        if nargout>4
        xvec(:,i+1)=x;
        end
		
		r=r*rmult; % 'Grow' r for next iteration
	end
	
	if(i==maxiter)
        disp('last value for x:')
        x
		warning('CONOPT:noConverge',...
		'Minimization did not converge in %i iterations',i);
	end	
	
	xhat=x;
	if nargout>1
	fhat=f(xhat);
	if nargout>2
	extpeniter=i;
    if nargout>4
	xvec=xvec(:,1:iter);
	end
	end
	end
	
		
end


		
function y=penalty_function(f,fcon,x,r)
	[gineq geq]=fcon(x);
	gineq(gineq<0)=0; % gineq=max(0,gineq)
	y=f(x)+r*diag(geq'*geq)'+r*sum(gineq.^2,1);
end