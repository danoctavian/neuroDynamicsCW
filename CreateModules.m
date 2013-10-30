function CreateModules

M = 100;

% check this with lecturer
F = 17; % scaling factor

C = zeros(M);

for m=1:1
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
       if (i ~= j && C(i, j) ~= 1)
           C(i,j) = 1;
           numberConnections = numberConnections + 1;
       end
    end
    
    C
    length(find(C))
end



