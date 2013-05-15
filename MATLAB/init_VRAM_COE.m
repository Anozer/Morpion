clear all
close all
clc

%********** Generation de la grille **********


% configs
% nb_X = 620;
% nb_Y = 480;
% cell_width = 30;
% border_width = 1;
% position = 10; % 'center' ou un nombre

nb_X = 620;
nb_Y = 480;
cell_width = 120;
border_width = 5;
position = 'center'; % 'center' ou un nombre

file = 'COE/VRAM.coe';

format = '%02X,\n';



% constantes utiles
if strcmp('center',position)
    x1 = (nb_X - (cell_width*3+4*border_width))/2;
    y1 = (nb_Y - (cell_width*3+4*border_width))/2;
else
    x1 = position;
    y1 = position;
end;

x2 = x1+cell_width+border_width;
x3 = x2+cell_width+border_width;
x4 = x3+cell_width+border_width;

y2 = y1+cell_width+border_width;
y3 = y2+cell_width+border_width;
y4 = y3+cell_width+border_width;

disp(sprintf('0 => "%s",\t-- x%d y%d',coord2addr(x1+border_width,y1+border_width,'bin',8,8),(x1+border_width),y1+border_width));
disp(sprintf('1 => "%s",\t-- x%d y%d',coord2addr(x2+border_width,y1+border_width,'bin',8,8),(x2+border_width),y1+border_width));
disp(sprintf('2 => "%s",\t-- x%d y%d',coord2addr(x3+border_width,y1+border_width,'bin',8,8),(x3+border_width),y1+border_width));
disp(sprintf('3 => "%s",\t-- x%d y%d',coord2addr(x1+border_width,y2+border_width,'bin',8,8),(x1+border_width),y2+border_width));
disp(sprintf('4 => "%s",\t-- x%d y%d',coord2addr(x2+border_width,y2+border_width,'bin',8,8),(x2+border_width),y2+border_width));
disp(sprintf('5 => "%s",\t-- x%d y%d',coord2addr(x3+border_width,y2+border_width,'bin',8,8),(x3+border_width),y2+border_width));
disp(sprintf('6 => "%s",\t-- x%d y%d',coord2addr(x1+border_width,y3+border_width,'bin',8,8),(x1+border_width),y3+border_width));
disp(sprintf('7 => "%s",\t-- x%d y%d',coord2addr(x2+border_width,y3+border_width,'bin',8,8),(x2+border_width),y3+border_width));
disp(sprintf('8 => "%s"\t\t-- x%d y%d' ,coord2addr(x3+border_width,y3+border_width,'bin',8,8),(x3+border_width),y3+border_width));

% init
VRAM = zeros(nb_Y,nb_X);
j = 0;

all_addr = zeros(1,2^19);

% passage de toutes les cord
for x=1:nb_X
    for y=1:nb_Y
        % détermination des lignes
        if ((x==x1 || x==x2 || x==x3 || x==x4) && (y>=y1 && y<(y4+border_width)))
            for(i=0:border_width-1)
                VRAM(y,x+i) = 255;
            end;
        end;
        
        % détermination des colonnes
        if ((y==y1 || y==y2 || y==y3 || y==y4) && (x>=x1 && x<(x4+border_width)))
            for(i=0:border_width-1)
                VRAM(y+i,x) = 255;
            end;
        end;
        
        % détermination des adresses
        if(VRAM(y,x) == 255)
            j = j+1;
            addr = coord2addr(x-1,y-1,'dec',10,9);
            all_addr(addr) = 255;
        end;
        
    end;
end;



% inscriptions dans un fichier
file = fopen(file,'w+');

line = sprintf('memory_initialization_radix=16;\nmemory_initialization_vector=\n');
fwrite(file,line);

for i=1:(2^19)-1
    line = sprintf(format,all_addr(i));
    fwrite(file,line);
    disp(i);
end;

line = sprintf('%02X;',all_addr(2^19));
fwrite(file,line);
disp(i);

fclose(file);



% affichage
figure();
imshow(VRAM);