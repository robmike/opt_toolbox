% Test cases for optimization functions
% Output is written to testcases_output.txt
% If you have v7 of Matlab you can turn on 'cell mode'
% to execute only portions of this worksheet at a time.

x6=zeros(6,1);

x2=[2,2]';
x=x6;
C=[12 3; 3 10]; b=[1;2]; x3=-inv(C)*b;

fid=fopen('testcases_output.txt','wt'); % Remember to close file descriptor

fprintf(fid,'\n ------------- Unconstrained opt -----------\n');
% TODO: The options used should be written to the file. How to do this?
% Struct has different/unknown data types
fprintf(fid,'Function\t Algo\t Gradmode\t xhat\t fhat\t iterations\n');

funcs={@f1,@f2,@f3};
for i=1:length(funcs)
    f=funcs{i};
    
class(f);
    
if isequal(f,@f1)
    x=x6;
elseif isequal(f,@f2)
    x=x2;
    elseif isequal(f,@f3)
    x=x3;
    else
    error('Edit the code and enter a starting value for all functions')
end

algos={'steepd','conjgrad','secant'}; 
gradmodes={'analyt','fd'};

for j=1:length(algos)
    for k=1:length(gradmodes)
        
        [xhat,fhat,iter]=fminimize(f,x,'unconalgo',algos{j},'gradmode',gradmodes{k});
        fprintf(fid,'%s\t %s\t %s\t [%e',func2str(f),algos{j},gradmodes{k},xhat(1));
        for l=2:length(xhat)
        fprintf(fid,',%e',xhat(l));
        end
        fprintf(fid,']\t %f\t %i\n',fhat,iter);

        %{
[xhat,fhat,iter]=steepd(f,x,'gradmode','analyt')
[xhat,fhat,iter]=steepd(f,x,'gradmode','fd')

[xhat,fhat,iter]=conjgrad(f,x,'gradmode','analyt')
[xhat,fhat,iter]=conjgrad(f,x,'gradmode','fd')
    
[xhat,fhat,iter]=secant(f,x,'gradmode','analyt')
[xhat,fhat,iter]=secant(f,x,'gradmode','fd')  
%}

    end
end
end

fclose(fid)

%% Other examples way to call unconstrained functions
%{
x0=[2 2]';
[xhat,fhat,iter]=fminimize(@f2,x0,'unconalgo','secant','tol',1e-7);
secant(f,x,'gradmode','fd','fdstepsize',1e-9);
conjgrad(f,x,'gradmode','analyt');
steepd(f,x);
%}

%% Comparison of minimizer given by implemented algorithms with actual
%% minimizer
f=@f1;

    C=[9 1 7 5 4 7; 1 11 4 2 7 5; 7 4 13 5 0 7; 5 2 5 17 1 9; ...
        4 7 0 1 21 15; 7 5 7 9 15 27];
    C=2*C;
    b=[1 4 5 4 2 1]';
    

xhat_actual=-inv(C)*b;
xhat=zeros(6,6);
x=zeros(6,1);

%{
xhat(:,1)=steepd(f,x,'gradmode','analyt');
xhat(:,2)=steepd(f,x,'gradmode','fd');

xhat(:,3)=conjgrad(f,x,'gradmode','analyt');
xhat(:,4)=conjgrad(f,x,'gradmode','fd');
    
xhat(:,5)=secant(f,x,'gradmode','analyt');
xhat(:,6)=secant(f,x,'gradmode','fd'); 
abs(repmat(xhat_actual,1,6)-xhat) % Error between actual and obtained minimizer
%}

fid=fopen('testcases_output.txt','at'); % Remember to close file descriptor
fprintf(fid,'\n ------------- Error from true value for example 1 -----------\n');

algos={'steepd','conjgrad','secant'}; 
gradmodes={'analyt','fd'};
for j=1:length(algos)
    for k=1:length(gradmodes)
        
        [xhat fhat]=fminimize(f,x,'unconalgo',algos{j},'gradmode',gradmodes{k});
        error=abs(xhat-xhat_actual);
        
        fprintf(fid,'%s\t %s\n',algos{j},gradmodes{k});
        fprintf(fid,'%e\n',error);
        fprintf(fid,'Mean square error: %e\n',norm(error));
        fprintf(fid,'Error of V(xhat): %e\n',abs(fhat-f1(xhat_actual)));
        %fprintf(fid,'%s\t %s\t %f',algos{j},gradmodes{k},error);
    end
end



fclose(fid);


%% Exterior penalty function
fid=fopen('testcases_output.txt','at'); % Remember to close file descriptor
fprintf(fid,'\n ------------- Exterior Penalty -----------\n');
% TODO: The options used should be written to the file. How to do this?
fprintf(fid,'Function\t Algo\t Gradmode\t xhat\t fhat\t con_iterations\t uncon_iter\n');
funcs={@f4,@f5,@f6};
confuncs={@f4con,@f5con,@f6con};

for i=1:length(funcs)
    f=funcs{i}
    fcon=confuncs{i};
[xhat,fhat,iter,unconiter]=extpen(f,fcon,[2 2]');

        fprintf(fid,'%s\t %s\t %s\t [%f',func2str(f),algos{j},gradmodes{k},xhat(1));
        for l=2:length(xhat)
        fprintf(fid,',%f',xhat(l));
        end
        fprintf(fid,']\t %f\t %i\t %i\n',fhat,iter,unconiter);
end

fclose(fid);

%% To turn off convergence warnings
warning('off','UNCONOPT:noConverge')

