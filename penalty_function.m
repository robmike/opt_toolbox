function y=penalty_function(f,fcon,r,x)
% Deprecated. Used now only for testing purposes.

[gineq geq]=fcon(x);
gineq(gineq<0)=0; % gineq=max(0,gineq)

y=f(x)+r*diag(geq'*geq)'+r*sum(gineq.^2,1);
