function [probs, complexities] = Question2

NUMBERTRIES = 20;
a = 0;
b = 0.5;
time = 60*1000; % simulation time: 60 seconds

complexities = zeros(1, NUMBERTRIES);

% generate NUMBERTRIES probabilites in the interval [a, b]
probs = a + (b-a).*rand(1, NUMBERTRIES);

% run the simulation for each probability
% and record the complexity
for i=1:NUMBERTRIES
    
    initial_layer = CreateModules;
    rewired_layer = Rewiring(probs(i), initial_layer);
    [~, averages] = RunModularNetwork(rewired_layer, time);
    
    % discard the first second of data
    averages(:, 1) = [];
    
    % apply differencing twice to render data 
    % covariance stationary
    s = aks_diff(aks_diff(averages));
    complexities(i) = Complexity(s');

end

