function MI = MutualInformation(S, i)

rest = S;
rest(:, i) = [];

MI = Entropy(S(:, i), size(S, 2)) + Entropy(rest, size(rest, 2)) - Entropy(S, size(S, 2));


end