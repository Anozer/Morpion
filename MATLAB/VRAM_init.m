clear all
close all
clc

%********** Generation de la grille **********


% configs
nb_X = 640;
nb_Y = 480;
cell_width = 140;
border_width = 5;


% constantes utiles
x1 = (nb_X - (cell_width*3+4*border_width))/2;
x2 = x1+cell_width+border_width;
x3 = x2+cell_width+border_width;
x4 = x3+cell_width+border_width;
y1 = (nb_Y - (cell_width*3+4*border_width))/2;
y2 = y1+cell_width+border_width;
y3 = y2+cell_width+border_width;
y4 = y3+cell_width+border_width;


% init
VRAM = zeros(nb_Y,nb_X);
j = 0;


% passage de toutes les cord
for x=1:nb_X
    for y=1:nb_Y
        % détermination des lignes
        if ((x==x1 || x==x2 || x==x3 || x==x4) && (y>=y1 && y<(y4+border_width)))
            for(i=0:4)
                VRAM(y,x+i) = 255;
            end;
        end;
        
        % détermination des colonnes
        if ((y==y1 || y==y2 || y==y3 || y==y4) && (x>=x1 && x<(x4+border_width)))
            for(i=0:4)
                VRAM(y+i,x) = 255;
            end;
        end;
        
        % détermination des adresses
        if(VRAM(y,x) == 255)
            j = j+1;
            addr(j) = bin2dec([dec2bin(y-1,9) dec2bin(x-1,10)]);
        end;
        
    end;
end;


% tri des adresses
addr = sort(addr);


% inscriptions dans un fichier
file = fopen('VRAM_init.vhd','w+');
for i=1:j
    line = sprintf('\t\t%d => x"%X",\n',addr(i),255);
    fwrite(file,line);
end;
fclose(file);

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


file = fopen('VRAM_init2.vhd','w+');
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
    
    data = (sprintf('\t\t%d to %d => "11111111",\n',mini, maxi));
    fwrite(file,data);
end;
fclose(file);


% affichage
figure();
imshow(VRAM);