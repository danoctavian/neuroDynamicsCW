function question1(prob)

layers = CreateModules2;
rewired_layers = Rewiring2(prob, layers);

[rewired_layers, average] = RunModularNetwork2(rewired_layers);

%Print the plots
%ModularNetwork2Plot(rewired_layers, average);

s = aks_diff(aks_diff(average));
Complexity ( s' )