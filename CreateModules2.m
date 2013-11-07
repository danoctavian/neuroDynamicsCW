function CreateModules2

EXCITATORY = 100; % Number of excitatory neurons in each module.
INHIBITORY = 200; % Total number of inhibitory neurons.
MODULES = 8; % Number of excitatory modules.
EXCITATORY_CONNECTIONS = 1000; % Number of random excitatory-excitatory connections.

%% Layer with excitatory neurons
r = rand(EXCITATORY,1);

layer{1}.a = 0.02*ones(EXCITATORY, 1);
layer{1}.b = 0.2*ones(EXCITATORY, 1);
layer{1}.c = -65+15*r.^2;
layer{1}.d = 8-6*r.^2;
layer{1}.rows = EXCITATORY;
layer{1}.columns = 1;

%% Layer with inhibitory neurons
    r = rand(INHIBITORY, 1);

    layer{2}.a = 0.02*ones(INHIBITORY, 1);
    layer{2}.b = 0.25*ones(INHIBITORY, 1);
    layer{2}.c = -65+15*r.^2;
    layer{2}.d = 2-6*r.^2;
    layer{2}.rows = INHIBITORY;
    layer{2}.columns = 1;
    
%% Initialising factors
layer{1}.factor{1} = 17;    % excitatory-excitatory
layer{1}.factor{2} = 2;     % inhibitory-excitatory
layer{2}.factor{1} = 50;    % excitatory-inhibitory
layer{2}.factor{2} = 1;     % inhibitory-inhibitory

%% Initialising delay
layer{1}.delay{1} = randi(21, EXCITATORY)-1;             % excitatory-excitatory
layer{1}.delay{2} = ones(EXCITATORY*MODULES, INHIBITORY);   % inhibitory-excitatory
layer{2}.delay{1} = ones(INHIBITORY, EXCITATORY*MODULES);   % excitatory-inhibitory
layer{2}.delay{2} = ones(INHIBITORY);                       % inhibitory-inhibitory
    
layer{1}.S{1} = zeros(EXCITATORY*MODULES); % Connectivity matrix from excitatory to excitatory.
layer{1}.S{1}(1:EXCITATORY*MODULES+1:end) = 0; % Remove "self-connections". 
layer{2}.S{1} = zeros(INHIBITORY, EXCITATORY*MODULES); % Connectivity matrix from excitatory to inhibitory.
    
%% Setup excitatory - excitatory connections
% Assign 1000 random connections within each module.
for m = 1:8
    numOfConnections = 0;
    while numOfConnections < EXCITATORY_CONNECTIONS
        i = randi(100,1)+((m-1)*100);
        j = randi(100,1)+((m-1)*100);
        if (i ~= j && layer{1}.S{1}(i, j) ~= 1)
            layer{1}.S{1}(i, j) = 1; % Weight for excitatory-excitatory connections is 1.
            numOfConnections = numOfConnections + 1;
        end
    end
end

%% Setup inhibitory - inhibitory connections
layer{2}.S{2} = -rand(INHIBITORY); % -1 to 0 weight.
layer{2}.S{2}(1:INHIBITORY+1:end) = 0; % Remove "self-connections".

%% Setup inhibitory - excitatory connections
layer{1}.S{2} = -rand(EXCITATORY, INHIBITORY); % -1 to 0 weight.

%% Setup excitatory - inhibitory connections.
for inhibitoryNeuron = 1:INHIBITORY
    targetModule = randi(8);
    
    for count = 1:4
        excitatoryNeuron = randi(100,1)+((targetModule-1)*100);
        
        while (layer{2}.S{1}(inhibitoryNeuron, excitatoryNeuron) ~= 0)
            excitatoryNeuron = randi(100,1)+((targetModule-1)*100);
        end
        
        layer{2}.S{1}(inhibitoryNeuron, excitatoryNeuron) = rand;
    end
end






    
 save('Network2.mat', 'layer');
    