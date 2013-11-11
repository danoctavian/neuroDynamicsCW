%-----------------------------------------------------------------------
% FUNCTION: RunModularNetwork.m
% PURPOSE:  simulate a given neural network for a given number of seconds
% 
% INPUTS:   layer:      2 layer neural network
%           TMax:       simulation time
%               
% OUTPUT:   layer:     the neural network for plotting
%           average:   mean firing rates for each module 8 * (TMax/20)
%-----------------------------------------------------------------------
function [layer, average] = RunModularNetwork(layer, TMax)

% Constants
Ib = 15;
lambda = 0.01;
Dmax = 20;
EXCITATORY = 100;
INHIBITORY = 200;
MODULES = 8;
TIMESHIFT = 20;

%% Initialise modules
layer{1}.v = -65.*ones(EXCITATORY*MODULES, 1);
layer{1}.u = layer{1}.b.*layer{1}.v;
layer{1}.firings = [];

layer{2}.v = -65*ones(INHIBITORY, 1);
layer{2}.u = layer{2}.b.*layer{2}.v;
layer{2}.firings = [];

%% Simulation
layer{1}.I = zeros(EXCITATORY*MODULES, 1);
layer{2}.I = zeros(INHIBITORY, 1);

for t = 1:TMax
    
    % display time every 100 ms
    if(mod(t, 100) == 0)
        t
    end
    
    layer{1}.I = Ib.*poissrnd(lambda, EXCITATORY*MODULES, 1);
    layer{2}.I = Ib.*poissrnd(lambda, INHIBITORY, 1);
    
    % update all neurons
    for i = 1:length(layer)
        layer = IzNeuronUpdate(layer, i, t, Dmax);
    end
end

excitatory_firings = layer{1}.firings;

%% Compute average mean firing rates for exitatory neurons
numberOfRuns = TMax / TIMESHIFT;
average = zeros(MODULES, numberOfRuns);

for i = 1:numberOfRuns
   indices = find((i-1)*20 < excitatory_firings(:, 1) & excitatory_firings(:, 1) <= 50+(i-1)*20);
   for module = 1:MODULES
        average(module, i) = size(find((module-1)*100 < excitatory_firings(indices, 2) & excitatory_firings(indices, 2) <= module*100), 1) / 50;
   end 
end
