function layer = IzNeuronUpdate(layer,j,t)
% Updates membrane potential v and reset rate u for neurons in layer i
% using Izhikevich's neuron model and the Euler method. Dmax is the maximum
% conduction delay

Dmax = 21;
dt = 0.2; % Euler method step size
% Calculate current from incoming spikes
for i=1:length(layer)
   %Dmax = layer{i}.Dmax{j}; 
   S = layer{i}.S{j};
   if ~isempty(S)
      firings = layer{j}.firings;
      if ~isempty(firings)
         % Find incoming spikes (taking account of propagation delays)
         delay = layer{i}.delay{j};
         F = layer{i}.factor{j};
         W = layer{i}.weight{j};
         % Sum current from incoming spikes
         k = size(firings,1); % number of neurons that fired
         while (k>0 && firings(k,1)>t-(Dmax+1)) % firings(k,1) is the time when the last firing took place
            spikes = (delay(:,firings(k,2))==t-firings(k,1)); % firings(k,2) is the index of the neuron that fired last
            if ~isempty(layer{i}.I(spikes))
               layer{i}.I(spikes) = layer{i}.I(spikes)+S(spikes,firings(k,2))*F*W;
            end
            k = k-1;
         end;
         % Don't let I go below zero (shunting inhibition)
         % layer{i}.I = layer{i}.I.*(layer{i}.I > 0);
      end
   end
end
% Update v and u using Izhikevich's model in increments of dt
for k=1:1/dt
   v = layer{j}.v;
   u = layer{j}.u;
   layer{j}.v = v+(dt*(0.04*v.^2+5*v+140-u+layer{j}.I));
   layer{j}.u = u+(dt*(layer{j}.a.*(layer{j}.b.*v-u)));
   % Reset neurons that have spiked
   fired = find(layer{j}.v>=30); % indices of spikes
   if ~isempty(fired)
      layer{j}.firings = [layer{j}.firings ; t+0*fired, fired];
      layer{j}.v(fired) = layer{j}.c(fired);
      layer{j}.u(fired) = layer{j}.u(fired)+layer{j}.d(fired);
   end
end