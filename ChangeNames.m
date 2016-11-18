clear all
close all
%%
d = 'D:\GN Luo\PDFtoXLS_NEW2\';

cd(d);
mkdir('NewName');
newd = strcat(d,'NewName\');

% Get all pdf files in the current folder
files = dir(strcat(d,'*.pdf'));
% strcut: Create structure array
% Loop through each
for ID = 1:length(files)
    % Get the file name (minus the extension)
    [~,oldName] = fileparts(files(ID).name);
    % fileparts: Parts of file name and path
    % [pathstr,name,ext] = fileparts(filename) 
    
    % Rename
    C = strsplit(oldName, ' ');
    % Split string at specified delimiter
    newName = strcat(C{3},C{2},C{1});
    movefile(strcat(d,files(ID).name),strcat(newd,sprintf('%s.pdf',newName)))
    %rename
    
end