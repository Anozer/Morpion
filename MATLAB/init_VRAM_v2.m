clear all
close all
clc

% principe :
% 1) Analyse de chaque image du dossier source
% 2) Récupère un fichier VHDL décrivant une ROM
% 3) Pour chaque image, on complète crée une ROM VHDL au complet


% répertoires source et destination
path_img = 'IMG/VRAM.png';
path_vhdl = 'VHDL/VRAM.vhd';

% init
nb_bitsX = 10;
nb_bitsY = 9;


disp('Generation VHDL...');
vhd = img2vhdl(path_img,nb_bitsX,nb_bitsY);
disp('Ecriture du fichier...');
vhd_file = fopen(path_vhdl,'w+');
fwrite(vhd_file, vhd);
fclose(vhd_file);


fprintf('done\n');
