function Rewiring2( probability )

load('Network2.mat', 'layer');

N = 800; % Total number of excitatory neurons.

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

figure(1)
spy(layer{1}.S{1});
figure(2)
spy(layer{2}.S{1});
figure(3)
spy(layer{1}.S{2});



