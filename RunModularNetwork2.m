function average = RunModularNetwork2(filename)

load(filename,'layer');

Tmax = 1000;
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

firings = layer{1}.firings;
average = cell(8, 1);

for i = 1:50
   indices = find((i-1)*20 < firings(:, 1) & firings(:, 1) <= 50+(i-1)*20);
   for module = 1:8
        average{module} = [average{module} size(find((module-1)*100 < firings(indices, 2) & firings(indices, 2) <= module*100), 1) / 50];
   end 
end

figure(1)
clf

subplot(2, 1, 2)
plot(1:20:1000, average{1}, 1:20:1000, average{2}, 1:20:1000, average{3}, 1:20:1000, average{4}, 1:20:1000, average{5}, 1:20:1000, average{6}, 1:20:1000, average{7}, 1:20:1000, average{8});

subplot(2, 1, 1)
plot(layer{1}.firings(:, 1), layer{1}.firings(:, 2), '.')
xlim([0 Tmax])
ylabel('Neuron number')
set(gca,'YDir','reverse')
title('I will be amazed if this works!')
    
drawnow




