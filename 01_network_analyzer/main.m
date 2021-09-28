## Import the data into an array of structs called 'experiment'.
filenames = glob("data/data*.csv");
experiment = struct;
j = 1;
for file = filenames'
    file = file{1};
    idx = j++;
    data = dlmread(file, "", 3, 0);
    [~, name, ext] = fileparts(file);
    experiment(idx).name = name;
    experiment(idx).filename = [name ext];
    experiment(idx).freq = data(:,1);
    experiment(idx).s = complex(data(:,2), data(:,3));
endfor
