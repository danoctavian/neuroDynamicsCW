function CreateModules

M = 100;
N = 200;

module = cell(1, 9); 
% check this with lecturer
F = 17; % scaling factor for excitatory-excitatory interactions



%% Setup 8 modules of excitatory neurons
for m=1:8
    module{m}.excitatoryConnectivity = zeros(M); %connectivity matrix
    
    % should this be global?
    r = rand(M);
    
    module{m}.a = 0.02*ones(M);
    module{m}.b = 0.2*ones(M);
    module{m}.c = -65+15*r.^2;
    module{m}.d = 8-6*r.^2;
    module{m}.D = ones(M).*floor(rand*20); % conduction delay
    
    numberConnections = 0;
    
    while numberConnections < 1000
       i = floor(rand*99) + 1;
       j = floor(rand*99) + 1;
       if (i ~= j && module{m}.excitatoryConnectivity(i, j) ~= 1)
           module{m}.excitatoryConnectivity(i,j) = 1;
           numberConnections = numberConnections + 1;
       end
    end
end

%% Excitatory to Inhibitory connections
module{9}.excitatory2Inhibitory = zeros(100, 200, 8);

module{9}.scalingFactor = 50;
module{9}.conductionDelay = 1;
module{9}.weights = rand(100, 200, M);

for inhibitoryNeuron = 1:N
  m = floor(rand*7) + 1;
  
  for count = 1:4
    excitatoryNeuron = floor(rand*99) + 1;
    
    while (module{9}.excitatory2Inhibitory(excitatoryNeuron, inhibitoryNeuron, m) == 1)
        excitatoryNeuron = floor(rand*99) + 1;
    end
    
    module{9}.excitatory2Inhibitory(excitatoryNeuron, inhibitoryNeuron, m) = 1;
  end
  
end

%% Inhibitory to excitatory
inhibitory2excitatory = ones(200, 100, 8);
scalingFactor = 2;

weights = rand(200, 100, 8) - 1;
conductionDelay = 1;

%% Inhibitory to inhibitory
inhibitory2inhibitory = ones(200);
inhibitory2inhibitory(1:201:end) = 0;
scalingFactor = 1;




