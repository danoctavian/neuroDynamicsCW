%-----------------------------------------------------------------------
% FUNCTION: Rewiring.m
% PURPOSE:  rewire a network of neurons for a given probability
% 
% INPUTS:   layer:          2 layered network of neurons
%           probability:    rewiring probability
%               
% OUTPUT:   layer:     rewired network, ready to be run
%-----------------------------------------------------------------------
function layer = Rewiring(probability, layer)

TOTAL_EXCITATORY = 800; % Total number of excitatory neurons.

% For each existing excitatory-excitatory connection within a module
% with a given probability create a new intermodular
% excitatory-excitatory connection.
INITIAL_CONNECTIVITY = layer{1}.S{1};

for i = 1:TOTAL_EXCITATORY
    for j = 1:TOTAL_EXCITATORY
        if(INITIAL_CONNECTIVITY(i, j) == 1 && rand < probability)

           layer{1}.S{1}(i, j) = 0;

           newM = randi(8,1);
           % Exclude the current module.
           while(newM == (floor(i/100)+1))
               newM = randi(8,1);
           end
           
           newNeuron = randi(100,1)+(newM-1)*100;
           while (layer{1}.S{1}(i, newNeuron) == 1)
               newNeuron = randi(100,1)+(newM-1)*100;
           end;

           layer{1}.S{1}(i, newNeuron) = 1;
        end
    end
end


