clear all
close all
clc

% répertoires source et destination
path_img = 'IMG/VRAM.png';
path_vhdl = 'VHDL/VRAM.vhd';
default_VRAM = 'VHDL/default_VRAM.vhd';
data_type = 'std_logic';

% init
bitsX = 10;
bitsY = 9;

% config image
nb_X = 640;
nb_Y = 480;
cell_width = 120;
border_width = 5;
posJx = 4;
posJy = 120;
victJx = 516;
victJy = 120;

% init coord zones pour shape generator
x1 = ((nb_X - (cell_width*3+4*border_width))/2) +border_width-1;
x2 = x1+cell_width+border_width;
x3 = x2+cell_width+border_width;
x4 = x3+cell_width+border_width;
y1 = ((nb_Y - (cell_width*3+4*border_width))/2) +border_width-1;
y2 = y1+cell_width+border_width;
y3 = y2+cell_width+border_width;
y4 = y3+cell_width+border_width;


fprintf('\t0 => "%s",\t-- x%d y%d\n' ,coord2addr(x1,y1,'bin',bitsX,bitsY),(x1),y1);
fprintf('\t1 => "%s",\t-- x%d y%d\n' ,coord2addr(x2,y1,'bin',bitsX,bitsY),(x2),y1);
fprintf('\t2 => "%s",\t-- x%d y%d\n' ,coord2addr(x3,y1,'bin',bitsX,bitsY),(x3),y1);
fprintf('\t3 => "%s",\t-- x%d y%d\n' ,coord2addr(x1,y2,'bin',bitsX,bitsY),(x1),y2);
fprintf('\t4 => "%s",\t-- x%d y%d\n' ,coord2addr(x2,y2,'bin',bitsX,bitsY),(x2),y2);
fprintf('\t5 => "%s",\t-- x%d y%d\n' ,coord2addr(x3,y2,'bin',bitsX,bitsY),(x3),y2);
fprintf('\t6 => "%s",\t-- x%d y%d\n' ,coord2addr(x1,y3,'bin',bitsX,bitsY),(x1),y3);
fprintf('\t7 => "%s",\t-- x%d y%d\n' ,coord2addr(x2,y3,'bin',bitsX,bitsY),(x2),y3);
fprintf('\t8 => "%s",\t-- x%d y%d\n' ,coord2addr(x3,y3,'bin',bitsX,bitsY),(x3),y3);
fprintf('\t9 => "%s",\t-- x%d y%d : info joueur\n',coord2addr(posJx,  posJy, 'bin',bitsX,bitsY),posJx,posJy);
fprintf('\t10 => "%s"\t-- x%d y%d : victoire\n'   ,coord2addr(victJx, victJy,'bin',bitsX,bitsY),victJx,victJy);

%%


%constantes
nb_bits = bitsX+bitsY;
addr_size  = sprintf('%d downto 0', nb_bits-1);
array_size = sprintf('(2**%d)-1 downto 0', nb_bits);

% Récup du VHDL de la VRAM à compléter
default_VRAM_file = fopen(default_VRAM, 'r+');
default_VRAM = fread(default_VRAM_file,'*char');
fclose(default_VRAM_file);

% calcul du VHDL des datas
disp('Generation VHDL...');
vhd = img2vhdl(path_img,bitsX,bitsY);

% completion du VHDL
disp('Ecriture du fichier...');
VRAM_vhdl = default_VRAM';
VRAM_vhdl = regexprep(VRAM_vhdl,'%ADDR_SIZE%', addr_size);
VRAM_vhdl = regexprep(VRAM_vhdl,'%ARRAY_SIZE%', array_size);
VRAM_vhdl = regexprep(VRAM_vhdl,'%DATA_TYPE%', data_type);
VRAM_vhdl = regexprep(VRAM_vhdl,'%DATAS%', vhd);

vhd_file = fopen(path_vhdl,'w+');
fwrite(vhd_file, VRAM_vhdl);
fclose(vhd_file);

fprintf('done\n');
