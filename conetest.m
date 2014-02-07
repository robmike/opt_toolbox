function y=conetest(s,gradv,theta)
% Returns a logical value of true if the angle between the vectors s and -gradv
% is less than theta radians. False otherwise.

y=(-s'*gradv>norm(s)*norm(gradv)*cos(theta)); % Returns a logical val
end