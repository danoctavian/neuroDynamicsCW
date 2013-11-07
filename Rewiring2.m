function Rewiring2( probability )

load('Network2.mat', 'layer');

N = 100; % Number of excitatory neurons in each module.

% For each existing excitatory-excitatory connection within a module
% with a given probability create a new intermodular
% excitatory-excitatory connection.
for i = 1:N
    for j = 1:N
        if(layer{1}.S{1}(i, j) == 1 && rand < probability)

           layer{1}.S{1}(i, j) = 0;

           newM = randi(8,1);
           newNeuron = randi(100,1)+(newM-1)*100;

           while(layer{1}.S{1}(newNeuron, i) == 1)
               newM = randi(8,1);
               newNeuron = randi(100,1)+(newM-1)*100;
           end

           layer{1}.S{1}(newNeuron, i) = 1;
        end
    end
end

filename = strcat('RewiredNetwork2', num2str(probability), '.mat');
save(filename, 'layer');

spy(layer{1}.S{1});



