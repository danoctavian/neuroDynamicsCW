function RunModularNetwork2(filename)

load(filename,'layer');

Tmax = 1000;
Ib = 15;
lambda = 0.01;
Dmax = 21;
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

for t = 1:Tmax
    
    %display time every 10 ms
    if(mod(t, 100) == 0)
        t
    end
    
    layer{1}.I = Ib.*poissrnd(lambda, M*8, 1);
    layer{2}.I = Ib.*poissrnd(lambda, N, 1);
    
    %update all neurons
    for i = 1:length(layer)
        layer = IzNeuronUpdate(layer, i, t, Dmax);
    end
end
    
figure(1)
clf

plot(layer{1}.firings(:, 1), layer{1}.firings(:, 2), '.')
xlim([0 Tmax])
ylabel('Neuron number')
set(gca,'YDir','reverse')
title('I will be amazed if this works!')
    

drawnow

save('filter.mat', 'layer');


