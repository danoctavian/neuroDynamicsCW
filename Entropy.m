function entropy = Entropy(S)

n = size(S, 2);
entropy = (1/2)*log((2*pi*exp(1))^n*det(cov(S)));

end

