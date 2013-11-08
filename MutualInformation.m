function MI = MutualInformation(S, i)

rest = S;
rest(:, i) = [];

MI = Entropy(S(:, i)) + Entropy(rest) - Entropy(S);

end