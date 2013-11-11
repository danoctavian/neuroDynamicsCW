%-----------------------------------------------------------------------
% FUNCTION: Entropy.m
% PURPOSE:  calculate the entropy of a system
% 
% INPUTS:   S:           nobs x nvar data matrix
%               
% OUTPUT:   entropy:     entropy of system
%-----------------------------------------------------------------------
function entropy = Entropy(S)

n = size(S, 2);
entropy = (1/2)*log((2*pi*exp(1))^n*det(cov(S)));

end

