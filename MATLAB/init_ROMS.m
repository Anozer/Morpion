clear all
close all
clc

% principe :
% 1) Analyse de chaque image du dossier source
% 2) R�cup�re un fichier VHDL d�crivant une ROM
% 3) Pour chaque image, on compl�te cr�e une ROM VHDL au complet


% r�pertoires source et destination
path_img = 'IMG';
path_vhdl = 'VHDL';
default_ROM = 'VHDL/ROM_default.vhd';

% init
nb_bitsX = 7;
nb_bitsY = 7;

% tailles des elements VHDL
rom_addr_tab = ['(2**' num2str(nb_bitsX+nb_bitsY) ')-1 downto 0'];
rom_addr_size = [num2str(nb_bitsX+nb_bitsY-1) ' downto 0'];

% R�cup du VHDL de la rom � compl�ter
default_ROM_file = fopen(default_ROM, 'r+');
default_ROM = fread(default_ROM_file,'*char');
fclose(default_ROM_file);

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
    rom_file = [rom_name '.vhd'];
    rom_path = [path_vhdl '/' rom_file];
    
    % check si l'extension est pr�sente dans la liste
    if (~sum(strcmp(type,types)))
        continue
    end;
     
    % R�cup du VHDL
    fprintf('Image:\t%s\nROM:\t%s\n...\n\n',img_path,rom_path);
    rom_data = img2vhdl(img_path, nb_bitsX, nb_bitsY);
    
    % Remplacement de la rom par d�faut
    rom_vhdl = default_ROM';
    rom_vhdl = regexprep(rom_vhdl,'%ROM_NAME%', rom_name);
    rom_vhdl = regexprep(rom_vhdl,'%DATAS%', rom_data);
    rom_vhdl = regexprep(rom_vhdl,'%ROM_ADDR_TAB%', rom_addr_tab);
    rom_vhdl = regexprep(rom_vhdl,'%ROM_ADDR_SIZE%', rom_addr_size);
    %rom_vhdl = regexprep(rom_vhdl,'%ROM_DATA_TYPE%', 'std_logic_vector(7 downto 0)');
    rom_vhdl = regexprep(rom_vhdl,'%ROM_DATA_TYPE%', 'std_logic');
    
    % Cr�ation du fichier VHDL pour la nouvelle ROM
    rom_file_des = fopen(rom_path, 'w+');
    fwrite(rom_file_des, rom_vhdl);
    fclose(rom_file_des);
end;


fprintf('done\n');
