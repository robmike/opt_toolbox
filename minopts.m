% MINOPTS.m
%
% Options must be specified in option-value pairs where the option is a
% string giving the name of the option and value is the corresponding value
% of the option. Options can be passed to functions by using a struct as
% shown below.
%
% An example of valid 'option' variable that can be passed to 
% params=struct(  'gradmode','fd',...
%                 'fstepsize',1.5,...
%                 'bstepsize',0.8,...
%                 'gradtol',1e-6,...
%                 'contol',1e-4,...
%                 'maxunconiter',500,...
%                 'maxconiter',100,...
%                 'conetheta',89.5,...
%                 'fdstepsize',1e-8,...
%                 'restartevery',20,...
%                 'penaltynumberstart',10,...
%                 'penaltynumbermult', 10, ...
%                 'verbose','on', ...
%                 'unconalgo', 'secant' ...
%             );
% 
% This can then be used in a minimization function as fminimize(f,x,params)
%
% Acceptable options and values:
% gradmode - {'analyt' or 'fd'}
%       Selects whether gradients should be computed analytically via a
%       user specified gradient function or using finite differences
% fdstepsize - real number >1
%       Step size to use in computing first order finite difference
%       approximation
% fstepsize - real number >1
%       Forward step size to use in Armijo search
% bstepsize - real number >0 and <1
%       Backward step size to use in Armijo search
% gradtol - real number >0
%       Stopping condition tolerance for gradient. Unconstrained algorithms
%       terminate when the absolute value of the gradient is less than this
%       number
% contol - real number >0
%       Stopping condition tolerand for constraints. Constrained algorithms
%       terminate when they are within this value of the constraint
% maxunconiter - real number >0
%       Maximum number of iterations before unconstrained algorithms give
%       up
% maxconiter - real number > 0
%       Maximum number of iteration before constrained algorithms give up.
%       (Does not include iterations of constrained algorithm that are
%       called by the unconstrained optimization function)
% conetheta - real number >0 <90
%       Theta for cone condition given in degrees
% restartevery - integer >0
%       conjgrad and secant restart every 'restartevery' iterations
% penaltynumberstart - real number >0
%       Initial value for penalty number (i.e. sigma) in penalty function
% penaltynumbermult - real number > 1
%       Value that penalty number is multiplied by at each iteration
% verbose - {'on','off'}
%       Some extra messages are printed when verbose is 'on'.
% unconalgo - {'secant','steepd','conjgrad'}
%       Method to use for unconstrained optimization: secant, steepest
%       descent or conjugate gradient
%
% Default values are given in initparams.m
