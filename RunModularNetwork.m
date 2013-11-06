function RunModularNetwork(filename)

load(filename,'module');

Tmax = 20;
Ib = 100;
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
    %module{2}.I = Ib*ones(100, 1);
    
    %module{1}.I = zeros(100,1);
    
    for i=1:8
        module{i}.I = zeros(100, 1);
    end
    
    module{randi(8)}.I(randi(100),1) = Ib;
    
    module{inhibitoryModule}.I = zeros(200,1);
    module{inhibitoryModule}.I(randi(200),1) = Ib;
    
    % update all the neurons
    for i = 1:length(module)
        module = IzNeuronUpdate(module, i, t);
    end
    
    for i = 1:8
        v{i}(t, 1:100) = module{i}.v;
        u{i}(t, 1:100) = module{i}.u;
    end
    
    v{inhibitoryModule}(t, 1:200) = module{inhibitoryModule}.v;
    u{inhibitoryModule}(t, 1:200) = module{inhibitoryModule}.u;
    
    
end

%for i = 1:9
%    module{i}.firings(:, 2) = module{i}.firings(:, 2)+((i-1)*100);
%    firings = [firings; module{i}.firings];
%end
    
figure(1)
clf


%if ~isempty(firings)
%    plot(firings(:,1),firings(:,2),'.');
%end

for i=1:9
    subplot(9,1,i)
    if ~isempty(module{i}.firings)
        plot(module{i}.firings(:,1), module{i}.firings(:,2),'.');
    end
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