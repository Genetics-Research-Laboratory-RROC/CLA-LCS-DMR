function RenameData(folder) 
clc
if exist(folder)
     A = dir( folder );
    for k = 1:length(A)
        if k>2
            n2=k-2;
        str=strcat(folder,'/Sample',num2str(n2));
            if exist(str)
                B=dir(str);
               for x = 1:length(B)
                   if x>2
                       n1=x-2;
                   str1=strcat(str,'/Chromosome',num2str(n1));
                   if exist(str1)
                       C=dir(str1);
                       for y=1:length(C)
                            if y>2
                               % delete([ str1 '/' C(y).name]);
                                [~, f,ext] = fileparts(C(y).name);
                                NewName=num2str(n1);
                                rename = strcat(str1, '/',NewName,ext) ;
                                oldName=strcat(str1, '/',C(y).name);
                                movefile(oldName, rename);
                            end
                       end
                   end
                   end
               end
            end
        end
    end
end  





%{

% Get all text files in the current folder.
files = dir('*.txt');
% Loop through each file.
for id = 1:length(files)
% Get the file name.
[~, f,ext] = fileparts(files(id).name);
rename = strcat('Cancer',ext) ;
movefile(files(id).name, rename);
end

%}