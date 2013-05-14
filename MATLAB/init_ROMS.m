clear all
close all
clc

% répertoires source et destination
path_img = 'IMG';
path_vhdl = 'VHDL';
default_ROM = 'VHDL/ROM_default.vhd';

% Récup du VHDL de la rom à compléter
default_ROM_file = fopen(default_ROM, 'r+');
default_ROM = fread(default_ROM_file,'*char');
fclose(default_ROM_file);

% types de fichier à convertir
types = {'jpg', 'jpeg', 'png', 'bmp', 'gif', 'tiff'};

% récup de tous les fichiers du dossier
dir_img = dir(path_img);

% pour chaque fichier du dossier
for i=1:length(dir_img) 
    
    % récup du nom et de l'extension
    img = dir_img(i).name;
    type  = regexprep(img,'.*\.(.+)$','$1');
    name = regexprep(img,'(.*)\..+$','$1');
    img_path = [path_img '/' img];
    rom_name = ['ROM_' name];
    rom_file = [rom_name '.vhd'];
    rom_path = [path_vhdl '/' rom_file];
    
    % check si l'extension est présente dans la liste
    if (~sum(strcmp(type,types)))
        continue
    end;
     
    % Récup du VHDL
    fprintf('Image:\t%s\nROM:\t%s\n...\n\n',img_path,rom_path);
    rom_data = img2vhdl(img_path, 7, 7);
    
    % Remplacement de la rom par défaut
    rom_vhdl = default_ROM';
    rom_vhdl = regexprep(rom_vhdl,'%ROM_NAME%', rom_name);
    rom_vhdl = regexprep(rom_vhdl,'%DATAS%', rom_data);
    rom_vhdl = regexprep(rom_vhdl,'%ROM_ADDR_TAB%', '(2**14)-1 downto 0');
    rom_vhdl = regexprep(rom_vhdl,'%ROM_ADDR_SIZE%', '13 downto 0');
    rom_vhdl = regexprep(rom_vhdl,'%ROM_DATA_SIZE%', '7 downto 0');
    
    % Création du fichier VHDL pour la nouvelle ROM
    rom_file_des = fopen(rom_path, 'w+');
    fwrite(rom_file_des, rom_vhdl);
    fclose(rom_file_des);
end;


fprintf('done\n');
