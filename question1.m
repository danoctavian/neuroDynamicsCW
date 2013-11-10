function Question1(probability)

TMax = 1000;

layers = CreateModules;
rewired_layer = Rewiring(probability, layers);

[rewired_layer, average] = RunModularNetwork(rewired_layer, TMax);

%Print the plots
PlotQ1(rewired_layer, average);

% s = aks_diff(aks_diff(average));
% Complexity ( s' )