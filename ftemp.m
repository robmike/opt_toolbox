function y=ftemp(x)
% A scrap function. Delete this m-file at any time
  
    C=[9 1 7 5 4 7; 1 11 4 2 7 5; 7 4 13 5 0 7; 5 2 5 17 1 9; ...
        4 7 0 1 21 15; 7 5 7 9 15 27];
    b=[1 4 5 4 2 1];
    a=5;
    
    y=a+b*x+0.5*x'*C*x;

end