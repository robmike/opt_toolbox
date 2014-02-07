function checkparam(this_param,val)
% Verify that option-value pair are valid
this_param=lower(this_param); % To lower case
		switch this_param
			case 'fstepsize'
				if ~isnumber(val)
					error(... 
					'fstepsize must be real scalar');
                elseif val<=1
					error(...
					'fstepsize must be > 1');
                end	
			case 'bstepsize'
				if ~isnumber(val)
					error(... 
					'bstepsize must be real scalar');
                elseif(val>=1 || val<=0)
					error(...
					'bstepsize must be 0<bstepsize<1');
                end	
                
			case 'gradmode'
				if ~ischar(val)
					error('gradmode must be a string');
                    
                elseif ~strcmp(val,'analyt') && ...
					~strcmp(val,'fd')
					error(...
				      'gradmode must be ''analyt'' or ''fd''');
                end
                
                
            case {'contol','maxunconiter','maxconiter','gradtol',...
                    'fdstepsize','penaltynumberstart'}
                errorifnotpositive(this_param,val);
		
	    case 'restartevery'
	    	errorifnotpositive(this_param,val);
		if fix(val)~=val
			error('''restartevery'' must be a positive integer');
		end
                
            case 'conetheta'
                if ~isnumber(val) || val<=0 || val>90
                   error('%s must be real, <= 90 and > 0',this_param);                    
                end
             
            case 'penaltynumbermult'
                if ~isnumber(val) || val<=1
                    error('%s must be real and > 1',this_param);
                end
                
            case 'unconalgo'
                if ~ischar(val)
					error('unconalgo must be a string');
                end
                
                switch val
                    case 'steepd'
                    case 'conjgrad'
                    case 'secant'
                    otherwise
                        error('Allowable values for unconalgo are steepd, conjgrad and secant');
                end
            
            case 'verbose'
                 if ~(ischar(val) && (strcmp('on',val) || strcmp('off',val)))
					error('verbose must ''on'' or ''off''');
                end
                                   
                             					
			otherwise
				error('Field %s is not a valid parameter',...
				this_param);
				next;
			end % end switch




end


% Subfunctions
%--------------------------
function y=isnumber(val)
	y=(isnumeric(val) && isscalar(val) && isreal(val) && isfinite(val) && ~isnan(val));
end


%----------------------------
function errorifnotpositive(this_param,val)
    if ~isnumber(val) || val<=0
        error('%s must be real and > 0',this_param);
    end
end