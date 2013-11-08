function complexity = Complexity(S)

complexity = 0;

for i=1:size(S, 2)
    complexity = complexity + MutualInformation(S, i);
end

complexity = complexity - Integration(S);