function RunModularNetwork(filename)

load(filename,'module');

Dmax = 10;
Tmax = 20;
Ib = 5;
inhibitoryModule = 9;
v = cell(1, 9);
firings = [];

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
        v{i}(t, 1:100) = module{i}.v;
        u{i}(t, 1:100) = module{i}.u;
    end
    
    v{inhibitoryModule}(t, 1:200) = module{inhibitoryModule}.v;
    u{inhibitoryModule}(t, 1:200) = module{inhibitoryModule}.u;
    
    
end

for i = 1:9
    module{i}.firings(:, 2) = module{i}.firings(:, 2)*i;
    firings = [firings; module{i}.firings];
end
    
figure(1)
clf

if ~isempty(firings)
    plot(firings(:,1),firings(:,2),'.');
end



% xlabel('Time (ms)')
xlim([0 Tmax])
ylabel('Neuron number')
ylim([0 1000])
set(gca,'YDir','reverse')
title('I will be amazed if this works!')


firings
size(firings)


drawnow    