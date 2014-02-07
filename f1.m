function [v,dv]=f1(x)

    [m,n]=size(x);
    
    if m~=6
       error('Input dimension must be 6 rows')
    end
    
    C=[9 1 7 5 4 7; 1 11 4 2 7 5; 7 4 13 5 0 7; 5 2 5 17 1 9; ...
        4 7 0 1 21 15; 7 5 7 9 15 27];
    b=[1 4 5 4 2 1]';
    a=5;
    
    C=2*C; % Because the problem gives the quadratic w/o 1/2 factor
    
    v=a+b'*x+0.5*diag(x'*C*x)';
    
    if nargout>1
       dv=b+C*x; 
    end

end