function entropy = Entropy( S, n )

entropy = 1/2*log((2*pi*e)^n*det(cov(S)));

end

