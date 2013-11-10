function RunModularNetwork(filename)

load(filename,'module');

Tmax = 200;
Ib = 15;
inhibitoryModule = 9;
v = cell(1, 9);
firings = [];
lambda = 0.01;

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

for i=1:8
   module{i}.I = zeros(100,1); 
end
module{inhibitoryModule}.I = zeros(200,1);
for t = 1:Tmax
    t

    % display time every 100ms
    if mod(t, 100) == 0
        module{randi(8)}.I = Ib.*poissrnd(lambda, 100, 1);
        t
    end
        
    %module{1}.I = Ib.*poissrnd(lambda, 100, 1);
    %for i=1:8
        %module{randi(8)}.I = Ib.*poissrnd(lambda, 100, 1);
    %end
    
    %module{inhibitoryModule}.I = zeros(200,1);
    %module{inhibitoryModule}.I = Ib.*poissrnd(lambda, 200, 1);
    % deliver current to all layers
    for i=1:8
        module{i}.I = Ib.*poissrnd(lambda, 100, 1);
    end 
    module{inhibitoryModule}.I = Ib.*poissrnd(lambda, 200, 1);
    
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

for i = 1:9
    if ~isempty(module{i}.firings)
        module{i}.firings(:, 2) = module{i}.firings(:, 2)+((i-1)*100);
        firings = [firings; module{i}.firings];
    end
end
    
figure(1)
clf


if ~isempty(firings)
    plot(firings(:,1),firings(:,2),'.');
end

%for i=1:9
%    subplot(9,1,i)
%    if ~isempty(module{i}.firings)
%        plot(module{i}.firings(:,1), module{i}.firings(:,2),'.');
%    end
%end

% xlabel('Time (ms)')
xlim([0 Tmax])
ylabel('Neuron number')
ylim([0 1000])
set(gca,'YDir','reverse')
title('I will be amazed if this works!')

%firings
%size(firings)

drawnow    