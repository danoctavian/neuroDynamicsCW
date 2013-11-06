function CreateModules

M = 100; % Number of excitatory neurons in each module.
N = 200; % Total number of inhibitory neurons.
inhibitoryModule = 9; % Index of module with the inhibitory neurons.

module = cell(1, 9); 

%% Setup 8 modules of excitatory neurons
for m = 1:8
    r = rand(M);
    
    module{m}.a = 0.02*ones(M);
    module{m}.b = 0.2*ones(M);
    module{m}.c = -65+15*r.^2;
    module{m}.d = 8-6*r.^2;
    module{m}.D = ones(M).*floor(rand*20); % conduction delay
   
    % Setup excitatory-excitatory connectivity matrices
    for i = 1:8
        module{m}.S{i} = zeros(M);
        module{m}.factor{i} = 17;
        module{m}.delay{i} = randi(20,0);
        module{m}.weight{i} = 1;
    end
    
    % Setup excitatory-inhibitory connectivity matrices
    module{m}.S{inhibitoryModule} = zeros(M, N);
    module{m}.factor{inhibitoryModule} = 50;
    module{m}.delay{inhibitoryModule} = 1;
    module{m}.weight{inhibitoryModule} = rand;
 
    % Create 1000 random excitatory-excitatory 
    % connections within each module.
    numberConnections = 0;
    while numberConnections < 1000
       i = randi(100,1);
       j = randi(100,1);
       if (i ~= j && module{m}.S{m}(i, j) ~= 1)
           module{m}.S{m}(i,j) = 1;
           numberConnections = numberConnections + 1;
       end
    end 
end

%% Setup the module with inhibitory neurons.
r = rand(M);

module{inhibitoryModule}.a = 0.02*ones(M);
module{inhibitoryModule}.b = 0.25*ones(M);
module{inhibitoryModule}.c = -65+15*r.^2;
module{inhibitoryModule}.d = 2-6*r.^2;

%% Setup excitatory-inhibitory connections.
% Each inhibitory neuron has connections from 4 excitatory neurons
% (all from the same module).
for inhibitoryNeuron = 1:N
  targetModule = randi(8,1);
  
  for count = 1:4
    excitatoryNeuron = randi(100,1);
    
    while (module{targetModule}.S{inhibitoryModule}(excitatoryNeuron, inhibitoryNeuron) == 1)
        excitatoryNeuron = randi(100,1);
    end
    
    module{targetModule}.S{inhibitoryModule}(excitatoryNeuron, inhibitoryNeuron) = 1;
    module{targetModule}.weight{inhibitoryModule}(excitatoryNeuron, inhibitoryNeuron) = rand;
  end
  
end    

%% Inhibitory to excitatory
for i = 1:8
    module{inhibitoryModule}.S{i} = ones(200, 100);
    module{inhibitoryModule}.weight{i} = rand - 1;
    module{inhibitoryModule}.scalingFactor{i} = 2;
    module{inhibitoryModule}.conductionDelay{i} = 1;
end

%% Inhibitory to inhibitory
module{inhibitoryModule}.S{inhibitoryModule} = ones(200);
module{inhibitoryModule}.S{inhibitoryModule}(1:201:end) = 0;
module{inhibitoryModule}.weight{inhibitoryModule} = rand - 1;
module{inhibitoryModule}.scalingFactor{inhibitoryModule} = 1;
module{inhibitoryModule}.conductionDelay{inhibitoryModule} = 1;

save('Network.mat', 'module');

