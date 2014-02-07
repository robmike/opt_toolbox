% MINFUNC.m
% Specifications for functions to be minimized.
%
% Function must have an input-output relationship given by:
% [v dv]=f(x) or v=f(x). The function takes as an argument a matrix and
% returns a row vector, v, with ith entry equal to f evaluated at the ith
% column of x. Optionally, it returns dv which is the corresponding 
% row vector of gradients. If 'analyt' minimization mode is to be used dv
% *must* be specified.
%