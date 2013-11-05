function Rewiring(probability)

load('Network.mat', 'module', 'inhibitory2excitatory', 'scalingFactorIE', 'weightsIE', 'conductionDelayIE', 'inhibitory2inhibitory', 'scalingFactorII', 'scalingFactorII', 'weightsII', 'scalingFactorEE');

N = 100;

for m = 1:8
   for i = 1:N
       for j = 1:N
           if(module{m}.excitatoryConnectivity(i, j) == 1 && rand < probability)
               module{m}.excitatoryConnectivity(i, j) = 0;
               newM = floor(rand*7) + 1;
               newTarget = floor(rand*99) + 1;
               
    
end


end