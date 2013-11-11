%-----------------------------------------------------------------------
% FUNCTION: MutualInformation.m
% PURPOSE:  computes mutual information between two parts of a system
% 
% INPUTS:   S:      nobs x nvar data matrix
%           i:      index of variable of sistem to compare with
%               
% OUTPUT:   MI:     mutual information   
%-----------------------------------------------------------------------
function MI = MutualInformation(S, i)

rest = S;
rest(:, i) = [];

MI = Entropy(S(:, i)) + Entropy(rest) - Entropy(S);

end