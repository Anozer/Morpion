clear all
close all
clc

% principe :
% 1) Analyse de chaque image du dossier source
% 2) R�cup�re un fichier VHDL d�crivant une ROM
% 3) Pour chaque image, on compl�te cr�e une ROM VHDL au complet


% r�pertoires source et destination
path_img = 'IMG_60px';
path_vhdl = 'COE';

% init
nb_bitsX = 6;
nb_bitsY = 6;

% types de fichier � convertir
types = {'jpg', 'jpeg', 'png', 'bmp', 'gif', 'tiff'};

% r�cup de tous les fichiers du dossier
dir_img = dir(path_img);

% pour chaque fichier du dossier
for i=1:length(dir_img) 
    
    % r�cup du nom et de l'extension
    img = dir_img(i).name;
    type  = regexprep(img,'.*\.(.+)$','$1');
    name = regexprep(img,'(.*)\..+$','$1');
    img_path = [path_img '/' img];
    rom_name = ['ROM_' name];
    rom_file = [rom_name '.coe'];
    rom_path = [path_vhdl '/' rom_file];
    
    % check si l'extension est pr�sente dans la liste
    if (~sum(strcmp(type,types)))
        continue
    end;
     
    % R�cup du VHDL
    fprintf('Image:\t%s\nROM:\t%s\n...\n\n',img_path,rom_path);
    rom_data = img2coe(img_path, nb_bitsX, nb_bitsY);
    
    % Cr�ation du fichier VHDL pour la nouvelle ROM
    rom_file_des = fopen(rom_path, 'w+');
    fwrite(rom_file_des, rom_data);
    fclose(rom_file_des);
end;


fprintf('done\n');
