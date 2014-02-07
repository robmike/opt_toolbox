function [xhat,fhat,iter,gradvec,xvec]=conjgrad(f,x0,varargin)
% Unconstrained non-linear programming (optimization) using conjugate
% gradient method.
% xhat = conjgrad(f,x0,options)
% Function takes:
% f - function handle to be minimized which must conform to the 
% specifications given in minfunc.m (help minfunc if minfunc.m is in Matlab 
% path or current working directory).
% x0 - An initial minimizer location
% options - An (optional) list of parameter-value pairs that specify 
% options. See minopts.m for more details.

    params=initparams();
    if ~isempty(varargin)
    params=setparams(params,varargin{:});
    end
    
    verbose=strcmp(params.verbose,'on');
    gradmode=params.gradmode;
    maxiter=params.maxunconiter;
    tol=params.gradtol;
    theta=params.conetheta;
    theta=theta/180*pi; %Convert to rads
    fstepsize=params.fstepsize;
    bstepsize=params.bstepsize;
    fdstepsize=params.fdstepsize;
    restart_count=params.restartevery;
    
    if fdstepsize>tol
        warning('''tol'' is less than ''fdstepsize''. Algorithm may not converge')
    end
    
    
    
	
	if ~isa(f,'function_handle')
		error('Expected function handle but received %s', class(f))
	end
	
	% Todo- Validate options
    
    iterguess=100; % Moderate overestimate of expected number of iterations
    gradvec=zeros(1,iterguess); % Norm of gradient at each iteration
    xvec=zeros(length(x0),iterguess); % Estimate of minimizer at each iteration
    
	x=x0;
	gradf_at_x=grad(f,x,gradmode,fdstepsize);
	s=-gradf_at_x;
	
	for i=0:maxiter
		normgrad=norm(gradf_at_x);
		if(normgrad<tol)
			break;
        end
        
        gradvec(i+1)=norm(gradf_at_x);
        xvec(:,i+1)=x;
		
		w=armijo(x,s,f,gradf_at_x,fstepsize,bstepsize);
		x=x+w*s;
		
		gradf_at_lastx=gradf_at_x;
		gradf_at_x=grad(f,x,gradmode,fdstepsize); %Grad(x_{j+1})
		
		b=[gradf_at_x-gradf_at_lastx]'*gradf_at_x;
		b=b/normgrad^2;
		s=-gradf_at_x+b*s;
        
        % Check if algorithm should be restarted (conetest and iter)
        if ~conetest(s,gradf_at_x,theta) || mod(i+1,restart_count)==0
           s=-gradf_at_x;
        end
	end
	
	if(i==maxiter)
		warning('UNCONOPT:noConverge',...
		'Minimization did not converge to specified precision in %d iterations',maxiter);
	end
	
	xhat=x;
	fhat=f(xhat);
	iter=i;
    
    xvec=xvec(:,1:iter);
    gradvec=gradvec(1:iter);

end
