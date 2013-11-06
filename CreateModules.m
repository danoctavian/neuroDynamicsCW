function CreateModules

M = 100; % Number of excitatory neurons in each module.
N = 200; % Total number of inhibitory neurons.
inhibitoryModule = 9; % Index of module with the inhibitory neurons.

module = cell(1, 9); 

%% Setup 8 modules of excitatory neurons
for m = 1:8
    r = rand(M, 1);
    
    % Setup parameters for excitatory neurons
    module{m}.a = 0.02*ones(M, 1);
    module{m}.b = 0.2*ones(M, 1);
    module{m}.c = -65+15*r.^2;
    module{m}.d = 8-6*r.^2;
   
    % Setup excitatory-excitatory connectivity matrices
    for i = 1:8
        module{m}.S{i} = zeros(M);
        module{m}.delay{i} = ones(M).*randi(20,0);
        module{m}.factor{i} = 17;
        module{m}.weight{i} = 1;
    end
    
    % Setup excitatory-inhibitory connectivity matrices
    module{m}.S{inhibitoryModule} = zeros(M, N);
    module{m}.delay{inhibitoryModule} = ones(M,N);
    module{m}.factor{inhibitoryModule} = 50;
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
r = rand(N, 1);

module{inhibitoryModule}.a = 0.02*ones(N, 1);
module{inhibitoryModule}.b = 0.25*ones(N, 1);
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
    module{inhibitoryModule}.delay{i} = ones(N,M);
    module{inhibitoryModule}.factor{i} = 2;
end

%% Inhibitory to inhibitory
module{inhibitoryModule}.S{inhibitoryModule} = ones(200);
module{inhibitoryModule}.S{inhibitoryModule}(1:201:end) = 0;
module{inhibitoryModule}.weight{inhibitoryModule} = rand - 1;
module{inhibitoryModule}.delay{inhibitoryModule} = ones(N);
module{inhibitoryModule}.factor{inhibitoryModule} = 1;

save('Network.mat', 'module');

