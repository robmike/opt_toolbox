function outparams = setparams(params, varargin)
% SETPARAMS - takes a list of parameter-value pairs from varargin and modifies 
% the associated parameters in params to take those values.

% Example:
% params=struct('colour','red',height,5); setparams(params,'height',8);
% Then outparams = struct('colour','red','height',8);

outparams=params;

if isempty(varargin)
   return; 
end

	%for i=1:length(params)
	%	param=params(i);		
	%end
    
    % TODO: Check if initparams() is a struct (or a list?)
    defaultfields=lower(fieldnames(initparams()));
    
    
    % Check if options come in pairs. (Maybe do bitand(x,2) or 2*fix(x/2))
    %varargin{1:2:end};
	if rem(length(varargin),2)~=0 
		error('Options must be specified in name-value pairs');
	end	
	
	% TODO: Check if params is a struct (or a list?)
	param_names=lower(fieldnames(params));
    
    members=ismember({varargin{1:2:end}},defaultfields);
    if ~all(members)
        error('Unrecognized option, %s', varargin{find(members==0).*2-1})
    end
    
	
	for i=1:2:length(varargin)
		this_param=varargin{i};
		val=varargin{i+1};
        
		if ~ischar(this_param)
			error('Field names must be strings');
		end
		
		this_param=lower(this_param);
		
        checkparam(this_param,val); % Verify that parameter-value pair is well defined
			
		try 
			params.(this_param)=val;
		catch	% This should never happen
			display('Bug: missed a case in error checking');
			lasterr
			error('Field %s is not a valid parameter',...
				this_param);
			next;
		end % end try-catch
	end % end for loop
	
outparams=params;
end




