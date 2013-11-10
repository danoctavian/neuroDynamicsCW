function [layer,average] = RunModularNetwork2(layer, TMax)

% Now we load the layer from parameter.
%load(filename,'layer');

Ib = 15;
lambda = 0.01;
Dmax = 20;
M = 100;
N = 200;

% Initialise modules
layer{1}.v = -65.*ones(M*8, 1);
layer{1}.u = layer{1}.b.*layer{1}.v;
layer{1}.firings = [];

layer{2}.v = -65*ones(N, 1);
layer{2}.u = layer{2}.b.*layer{2}.v;
layer{2}.firings = [];

%% Simulation!!!!!

layer{1}.I = zeros(M*8, 1);
layer{2}.I = zeros(N, 1);

for t = 1:TMax
    
    %display time every 10 ms
    if(mod(t, 100) == 0)
        t;
    end
    
    layer{1}.I = Ib.*poissrnd(lambda, M*8, 1);
    layer{2}.I = Ib.*poissrnd(lambda, N, 1);
    
    %update all neurons
    for i = 1:length(layer)
        layer = IzNeuronUpdate(layer, i, t, Dmax);
    end
end

firings = layer{1}.firings;
average = [];

for i = 1:(TMax / 20)
   indices = find((i-1)*20 < firings(:, 1) & firings(:, 1) <= 50+(i-1)*20);
   for module = 1:8
        average(module, i) = size(find((module-1)*100 < firings(indices, 2) & firings(indices, 2) <= module*100), 1) / 50;
   end 
end




