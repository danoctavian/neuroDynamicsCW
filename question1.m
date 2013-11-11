%-----------------------------------------------------------------------
% FUNCTION: Question1.m
% PURPOSE:  run the simulation for question 1 to obtain plots
% 
% INPUTS:   probability:      probability between 0 and 1
%-----------------------------------------------------------------------
function Question1(probability)

% set time to 1000 ms
TMax = 1000;

layers = CreateModules;
rewired_layer = Rewiring(probability, layers);

[rewired_layer, average] = RunModularNetwork(rewired_layer, TMax);

% Generate Plots (connectivity matrix, raster plot, mean firing rates)
PlotQ1(rewired_layer, average);