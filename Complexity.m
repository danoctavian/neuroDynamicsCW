%-----------------------------------------------------------------------
% FUNCTION: Complexity.m
% PURPOSE:  calculate neural complexity
% 
% INPUTS:   S:              nobs x nvar data matrix
%               
% OUTPUT:   complexity:     neural complexity for given input   
%-----------------------------------------------------------------------
function complexity = Complexity(S)

complexity = 0;

for i=1:size(S, 2)
    complexity = complexity + MutualInformation(S, i);
end

complexity = complexity - Integration(S);