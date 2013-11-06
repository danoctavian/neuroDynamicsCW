function RunModularNetwork(filename)

load(filename,'module');

Dmax = 10;
Tmax = 1000;
Ib = 5;
inhibitoryModule = 9;
v = cell(1, 9);
firings = cell(1, 9);

% Initialise modules
for m = 1:8
    
    module{m}.v = -65*ones(100, 1);
    module{m}.u = module{m}.b.*module{m}.v;
    module{m}.firings = [];

end

module{inhibitoryModule}.v = -65*ones(200, 1);
module{inhibitoryModule}.u = module{inhibitoryModule}.b.*module{inhibitoryModule}.v;
module{inhibitoryModule}.firings = [];

% SIMULATION!!!!!

for t = 1:Tmax

    % display time every 100ms
    if mod(t, 100) == 0
        t
    end
    
    % deliver constant base current to module 1
    module{1}.I = Ib*ones(100, 1);
    
    for i=2:8
        module{i}.I = zeros(100, 1);
    end
    
    module{inhibitoryModule}.I = zeros(200, 1);
    
    % update all the neurons
    for i = 1:length(module)
        module = IzNeuronUpdate(module, i, t, Dmax);
    end
    
    for i = 1:8
        size(v{i})
        module{i}.v
        v{i}(t, 1:100) = module{i}.v;
        u{i}(t, 1:100) = module{i}.u;
    end
    
    v{inhibitoryModule}(t, 1:200) = module{inhibitoryModule}.v;
    u{inhibitoryModule}(t, 1:200) = module{inhibitoryModule}.u;
    
    
end

for i = 1:8
    firings{i} = module{i}.firings;
end

firings{inhibitoryModule} = module{inhibitoryModule}.firings;
    
figure(1)
clf

subplot(2,1,1)
for i = 1:9

    if ~isempty(firings{i})
       plot(firings{i}(:,1),firings{i}(:,2),'.')
       hold on
    end
  
end

% xlabel('Time (ms)')
xlim([0 Tmax])
ylabel('Neuron number')
ylim([0 1000])
set(gca,'YDir','reverse')
title('I will be amazed if this works!')

drawnow    