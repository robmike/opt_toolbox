function [w,iter]=armijo(xj,sj,f,gradf_at_xj,fstepsize,bstepsize)
% Armijo algorithm.
% xj is current minimizer estimate, sj is the search direction
% f is the function to be minimized, conforming to minfunc.m
% gradf_at_xj is the gradient at xj. fstepsize and bstepsize are the
% forward and backward step sizes respectively.
% fstepsize must be >1 and bstepsize >0 and <1.
% Returns estimate of optimal step size to advance along search direction, w, 
% and number of iterations taken to obtain it.
% Algorithm gives up if it does not 'converge' after maxiter forward
% iterations or maxiter backward iterations.
maxiter=1000; 

w=1;
v=f(xj);
gradv=gradf_at_xj;

for p=0:maxiter
    vhat=v+0.5*w*gradv'*sj;
    if(f(xj+w*sj) >= vhat)
		break;
    end
    w=w*fstepsize;	
end

if(p==maxiter)
	error('Armijo algorithm did not converge. Try different step sizes');
end

for q=0:maxiter

    vhat=v+0.5*w*gradv'*sj;
    if(f(xj+w*sj) <= vhat)
		break;
    end
    w=w*bstepsize;
end
if(p==maxiter)
	error('Armijo algorithm did not converge. Try different step sizes');
end

iter=p+q+2;

end
