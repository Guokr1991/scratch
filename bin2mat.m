% plane wave acquisition binary conversion
files=dir('*.bin');
for i=1:length(files)
    fprintf('Converting %d of %d\n',i,length(files));
    [path name ext]=fileparts(files(i).name);
    fin=fopen(files(i).name);
    data=single(fread(fin,inf,'single'));
    fclose(fin);
    load(name)
    data=reshape(data,[length(data)/rfdata.numElementsPerXmt/rfdata.numFrames,...
                rfdata.numElementsPerXmt rfdata.numFrames]);
    rfdata.data=data;
    save(['complete_' name],'rfdata','params','-v7.3');
end