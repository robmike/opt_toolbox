function [xhat,fhat,iter,gradvec,xvec]=fminimize(f,x0,varargin)
% Unconstrained non-linear programming (optimization). 
% xhat = fminimize(f,x0,options)
% Function takes:
% f - function handle to be minimized which must conform to the 
% specifications given in minfunc.m (help minfunc if minfunc.m is in Matlab 
% path or current working directory).
% x0 - An initial minimizer location
% options - An (optional) list of parameter-value pairs that specify 
% options. See minopts.m for more details.
% Minimization algorithm can be specified using options

    params=initparams();
    params=setparams(params,varargin{:});

    algo=params.unconalgo;

    [xhat,fhat,iter,gradvec,xvec]=feval(algo,f,x0,varargin{:});


end