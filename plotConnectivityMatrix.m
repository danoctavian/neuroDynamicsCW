function plotConnectivityMatrix(filename)

load(filename, 'module');

final = [];
row = [];

for i = 1:8
    row = [];
    
    for j = 1:8
        row = [row module{i}.S{j}];
    end
    
    final = [final; row];
end

spy(final);
end