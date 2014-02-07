% fcon.m
% Specifications for constraint functions.
%
% Function should have an input-output relationship given by:
% [c ceq]=fcon(x). 
% The function takes as an argument a vector and
% returns two column vectors c, ceq, with ith entry corresponding to the ith
% inequality or equality constraint equation evaluated at x respectively.
% The ith inequality constraint is given by c_i(x)<= 0  where c_i(x) is the
% ith inequality constraint equation. Similarly, ceq_i(x)==0 is the ith
% equality constraint with ceq_i(x) being the ith equality constraint
% equation.
%
% Both c and ceq are mandatory (they must be returned by the function). In
% the case that there are no equality of inequality constraints they may be
% set to zero in the function, effectively specifying a 'dummy' constraint
% which is always satisfied.