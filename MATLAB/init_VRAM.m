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

nb_X = 640;
nb_Y = 480;
cell_width = 120;
border_width = 5;
position = 'center'; % 'center' ou un nombre

file = 'VHDL/VRAM.vhd';
file_condensed='VHDL/VRAM.min.vhd';

bitsX = 10;
bitsY = 9;

posJx = 4;
posJy = 179;

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

disp(sprintf('0 => "%s",\t-- x%d y%d' ,coord2addr(x1+border_width-1,y1+border_width-1,'bin',bitsX,bitsY),(x1+border_width),y1+border_width));
disp(sprintf('1 => "%s",\t-- x%d y%d' ,coord2addr(x2+border_width-1,y1+border_width-1,'bin',bitsX,bitsY),(x2+border_width),y1+border_width));
disp(sprintf('2 => "%s",\t-- x%d y%d' ,coord2addr(x3+border_width-1,y1+border_width-1,'bin',bitsX,bitsY),(x3+border_width),y1+border_width));
disp(sprintf('3 => "%s",\t-- x%d y%d' ,coord2addr(x1+border_width-1,y2+border_width-1,'bin',bitsX,bitsY),(x1+border_width),y2+border_width));
disp(sprintf('4 => "%s",\t-- x%d y%d' ,coord2addr(x2+border_width-1,y2+border_width-1,'bin',bitsX,bitsY),(x2+border_width),y2+border_width));
disp(sprintf('5 => "%s",\t-- x%d y%d' ,coord2addr(x3+border_width-1,y2+border_width-1,'bin',bitsX,bitsY),(x3+border_width),y2+border_width));
disp(sprintf('6 => "%s",\t-- x%d y%d' ,coord2addr(x1+border_width-1,y3+border_width-1,'bin',bitsX,bitsY),(x1+border_width),y3+border_width));
disp(sprintf('7 => "%s",\t-- x%d y%d' ,coord2addr(x2+border_width-1,y3+border_width-1,'bin',bitsX,bitsY),(x2+border_width),y3+border_width));
disp(sprintf('8 => "%s",\t-- x%d y%d',coord2addr(x3+border_width-1,y3+border_width-1,'bin',bitsX,bitsY),(x3+border_width),y3+border_width));
disp(sprintf('9 => "%s"\t\t-- x%d y%d : info joueur' ,coord2addr(posJx, posJy,'bin',bitsX,bitsY),posJx,posJy));
% init
VRAM = zeros(nb_Y,nb_X);
j = 0;


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
        
        if(x==(x1+border_width) && y==y1+border_width)
            for(xi=0:cell_width)
                for(yi=0:cell_width)
                    VRAM(y+yi,x+xi) = 255;
                end;
            end;
        end;
        
        % détermination des adresses
        if(VRAM(y,x) == 255)
            j = j+1;
            addr(j) = coord2addr(x-1,y-1,'dec',bitsX,bitsY);
        end;
        
    end;
end;


% tri des adresses
addr = sort(addr);


% inscriptions dans un fichier
file = fopen(file,'w+');
for i=1:j
    %line = sprintf('\t\t%d => x"%X",\n',addr(i),255);
    line = sprintf('\t\t%d => ''%d'',\n',addr(i),1);
    fwrite(file,line);
end;
fclose(file);


% condensé
a=1;
old_addr = 0;
new_addr = 0;
lines = [];
for i=1:j
    new_addr = addr(i);
    
    if(new_addr == old_addr+1)
        b = b+1;
    else
        a = a+1;
        b = 1;
    end;
    
    lines(a,b) = new_addr;
    
    old_addr = new_addr;
end;

disp(sprintf('Taille min de la RAM : %d (2^%d)\n', old_addr, ceil(log2(old_addr))));

% écriture du condensé
file = fopen(file_condensed,'w+');
for i=1:a
    line = lines(i,:);
    
    maxi = max(line);
    if(maxi == 0)
        continue;
    end;
    
    [mini mini_pos] = min(line);
    if(mini == 0)
       mini = min(line(1:mini_pos-1));
    end;
    
    %data = (sprintf('\t\t%d to %d => "11111111",\n',mini, maxi));
    data = (sprintf('\t\t%d to %d => ''1'',\n',mini, maxi));
    fwrite(file,data);
end;
fclose(file);


% affichage
figure();
imshow(VRAM);