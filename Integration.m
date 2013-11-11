%-----------------------------------------------------------------------
% FUNCTION: Integration.m
% PURPOSE:  calculate integration of system s
% 
% INPUTS:   S:               nobs x nvar data matrix
%               
% OUTPUT:   integration:     integration of system   
%-----------------------------------------------------------------------
function integration = Integration(S)

integration = 0;
systemEntropy = Entropy(S);

for i = 1:size(S, 2)
    integration = integration + Entropy(S(:, i));
end

integration = integration - systemEntropy;