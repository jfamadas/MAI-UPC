function [data,tagset] = loadAll()
    % Read All files and obtain the data and tagset.
    f=dir(['..\data\*.csv']);
    disp(numel(f))
    counter = 0;
    for k=1:numel(f)
        file_name = f(k).name(1:strfind(f(k).name,'.')-1);
        [x, y, tagset_sequence] = load_file(file_name);
        if (size(x,1)>0)
            counter=counter+1;
            data(counter) = dataSequences(x,y);
            tagset{counter} = tagset_sequence;
        end
    end

return 


