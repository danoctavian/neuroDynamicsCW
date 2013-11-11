%-----------------------------------------------------------------------
% FUNCTION: Question2.m
% PURPOSE:  run 20 simulation for 60 seconds, compute neural complexities
%           and generate plot of probabilties and complexities
%
% INPUT:    n:              number of tries
% OUTPUT:   probs:          array of probabilities 1 x 20
%           complexitties:  array of calculates neural complexities 1 x 20
%-----------------------------------------------------------------------
function [probs, complexities] = Question2(n)

NUMBERTRIES = n;
a = 0.1;
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

% plot the complexities for each rewiring probability
figure(1)
clf 

plot(probs, complexities, '.')
xlim([0 0.5])
xlabel('Rewiring probability p')
ylabel('Neural Complexity')