function Rewiring(probability)

load('Network.mat', 'module');

N = 100;

for m = 1:8
   for i = 1:N
       for j = 1:N
           if(module{m}.S{m}(i, j) == 1 && rand < probability)
               
               module{m}.S{m}(i, j) = 0;
               
               newM = floor(rand*7) + 1;
               newNeuron = floor(rand*99) + 1;
               
               while(module{m}.S{newM}(newNeuron, i) == 1)
                   newM = floor(rand*7) + 1;
                   newNeuron = floor(rand*99) + 1;
               end
               
               module{m}.S{newM}(newNeuron, i) = 1;
           end
       end
   end
end

save('RewiredNetwork.mat', 'module');

end