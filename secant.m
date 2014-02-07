function [xhat,fhat,iter,gradvec,xvec]=secant(f,x0,varargin)
% Unconstrained non-linear programming (optimization) using secant
% method with symmetric rank-1 update scheme
% xhat = secant(f,x0,options)
% Function takes:
% f - function handle to be minimized which must conform to the 
% specifications given in minfunc.m (help minfunc if minfunc.m is in Matlab 
% path or current working directory).
% x0 - An initial minimizer location
% options - An (optional) list of parameter-value pairs that specify options. See
% minopts.m for more details.
    
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
	H=eye(length(x));
	gradf_at_x=grad(f,x,gradmode,fdstepsize);
	
	for i=0:maxiter
		
		s=-H*gradf_at_x;
        
    % Check if algorithm should be restarted (conetest and iter)
    % (Restarts on the first iteration. Unnecessary but no problem)
        if(~conetest(s,gradf_at_x,theta) || mod(i,restart_count)==0)
           s=-gradf_at_x; %ok
           H=eye(length(x));
        end

		w=armijo(x,s,f,gradf_at_x,fstepsize,bstepsize);
		
		lastx=x;
		gradf_at_lastx=gradf_at_x;
        
        gradvec(i+1)=norm(gradf_at_x);
        xvec(:,i+1)=x;
		
		x=x+w*s;
		x=real(x); % Matlab's computation's can sometimes result in complex values
		gradf_at_x=grad(f,x,gradmode,fdstepsize);
		
		if(norm(gradf_at_x)<tol)
			break;
		end
		
		dx=x-lastx;
		dgrad=gradf_at_x-gradf_at_lastx;
		
		H=H_srupdate(dx,dgrad,H); %Symmetric rank-1 update
        
        
	end
	
	if(i==maxiter)
		warning('UNCONOPT:noConverge',...
		'Minimization did not converge in %d iterations',maxiter);
	end
	
	xhat=x;
	fhat=f(xhat);
	iter=i;
 
    xvec=xvec(:,1:iter);
    gradvec=gradvec(1:iter);

end

%-----------------------------------------------
function y=H_srupdate(dx,dgrad,H)
% Symmetric rank-1 update scheme
    tol=1e-8;
	
	z=dx-H*dgrad;
	r=z'*dgrad;
	y=H;
	
	if(abs(r)>tol)
		y=y+z*z'/r;
	end
	% else y=H;
	
end
