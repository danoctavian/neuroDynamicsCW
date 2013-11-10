function integration = Integration(S)

integration = 0;
systemEntropy = Entropy(S);

for i = 1:size(S, 2)
    integration = integration + Entropy(S(:, i));
end

integration = integration - systemEntropy;