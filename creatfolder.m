clear all
close all
%%
d = 'D:\GN Luo\PDFtoXLS_NEW2\';
cd(d);

% Get all pdf files in the current folder
files = dir(strcat(d,'*.pdf'));
% strcut: Create structure array
% Loop through each
for ID = 1:length(files)
    % Get the file name (minus the extension)
    [~,f] = fileparts(files(ID).name);
    % fileparts: Parts of file name and path
    % [pathstr,name,ext] = fileparts(filename) 
    
    % make new folder according to the file name
    mkdir(f);
    
end