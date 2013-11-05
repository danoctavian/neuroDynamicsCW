function CreateModules

M = 100;
N = 200;
inhibitoryModule = 9;

module = cell(1, 9); 

%% Setup 8 modules of excitatory neurons
for m = 1:8
    r = rand(M);
    
    module{m}.a = 0.02*ones(M);
    module{m}.b = 0.2*ones(M);
    module{m}.c = -65+15*r.^2;
    module{m}.d = 8-6*r.^2;
    module{m}.D = ones(M).*floor(rand*20); % conduction delay
   
    % Connectivity matrices
    for i = 1:8
        module{m}.S{i} = zeros(M);
        module{m}.factor{i} = 17;
        module{m}.delay{i} = floor(rand*19) + 1;
        module{m}.weight{i} = 1;
    end
    
    module{m}.S{inhibitoryModule} = zeros(M, N);
    module{m}.factor{inhibitoryModule} = 50;
    module{m}.delay{inhibitoryModule} = 1;
    module{m}.weight{inhibitoryModule} = rand;
 
    numberConnections = 0;
    
    while numberConnections < 1000
       i = floor(rand*99) + 1;
       j = floor(rand*99) + 1;
       if (i ~= j && module{m}.S{m}(i, j) ~= 1)
           module{m}.S{m}(i,j) = 1;
           numberConnections = numberConnections + 1;
       end
    end 
end

r = rand(M);

module{inhibitoryModule}.a = 0.02*ones(M);
module{inhibitoryModule}.b = 0.25*ones(M);
module{inhibitoryModule}.c = -65+15*r.^2;
module{inhibitoryModule}.d = 2-6*r.^2;
    
for inhibitoryNeuron = 1:N
  targetModule = floor(rand*7) + 1;
  
  for count = 1:4
    excitatoryNeuron = floor(rand*99) + 1;
    
    while (module{targetModule}.S{inhibitoryModule}(excitatoryNeuron, inhibitoryNeuron) == 1)
        excitatoryNeuron = floor(rand*99) + 1;
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

