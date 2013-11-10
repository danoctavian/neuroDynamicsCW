function PlotQ1( layer, average )

figure(1)
spy(layer{1}.S{1});
figure(2)
spy(layer{2}.S{1});
figure(3)
spy(layer{1}.S{2});


figure(4)
clf

subplot(2, 1, 2)
plot(1:20:1000, average(1, :), 1:20:1000, average(2, :), 1:20:1000, average(3,:), 1:20:1000, average(4,:), 1:20:1000, average(5,:), 1:20:1000, average(6,:), 1:20:1000, average(7, :), 1:20:1000, average(8,:));

subplot(2, 1, 1)
plot(layer{1}.firings(:, 1), layer{1}.firings(:, 2), '.')
xlim([0 1000])
ylabel('Neuron number')
set(gca,'YDir','reverse')
title('Neuron Firings')
    
drawnow

end

