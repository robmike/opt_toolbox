function y = grad(f,x,gradmode,h)
% Wrapper function to compute the gradient of the function handle f 
% either numerically or analytically. f(x) must return as it's first argument
% the function value at x. In addition, it must output a second argument, being
% the gradient of f at x if 'analyt' gradmode is used.
% Acceptable values of gradmode are 'analyt' and 'fd', corresponding to
% analytic mode and (first order forward) finite difference mode.
% The two acceptable ways to call this function are:
%
% grad(f,x,'analyt') and grad(f,x,'fd',h) where
% h is the step size for the finite difference.
% grad(f,x,'analyt',h) is also acceptable (h is ignored)

% Most likely not efficient due to if statements and string comparisons
% Function is called heavily in a loop so this is a potential problem (if
% speed is a concern).
% Maybe Matlab interpreter will save us and optimize it.

    error(nargchk(3,4,nargin,'struct'));
    
    switch gradmode
        case 'analyt'
            [v,y]=f(x);
        case 'fd'
            if nargin~=4
                error(nargchk(4,4,nargin,'struct'));
            end
            y=finite_diff(f,x,h);
        otherwise
            error('''gradmode'' not recognized')
    end


end