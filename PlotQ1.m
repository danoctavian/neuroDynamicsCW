%-----------------------------------------------------------------------
% FUNCTION: Plot1.m
% PURPOSE:  plots the data for question 1
% 
% INPUTS:   layer:      2 layer neural network
%           average:    average mean firing rates for each module 8 x 50
%-----------------------------------------------------------------------
function PlotQ1( layer, average )

% connectivity matrix
figure(1)
clf

matrix1 = [layer{1}.S{1} layer{1}.S{2}];
matrix2 = [layer{2}.S{1} layer{2}.S{2}];
matrix = [matrix1; matrix2];
spy(matrix);

figure(2)
clf

% average mean firing rates for each module
subplot(2, 1, 2)
plot(1:20:1000, average(1, :), 1:20:1000, average(2, :), 1:20:1000, average(3,:), 1:20:1000, average(4,:), 1:20:1000, average(5,:), 1:20:1000, average(6,:), 1:20:1000, average(7, :), 1:20:1000, average(8,:));
xlim([0 1000])
ylabel('Mean Firing Rate')
xlabel('Time (ms) + 0s')

% raster plot of firings for excitatory neurons
subplot(2, 1, 1)
plot(layer{1}.firings(:, 1), layer{1}.firings(:, 2), '.')
xlim([0 1000])
ylabel('Neuron number')
set(gca,'YDir','reverse')
xlabel('Time (ms) + 0s')
    
drawnow

end

