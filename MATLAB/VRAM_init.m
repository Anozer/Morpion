clear all
close all
clc

VRAM = zeros(480,640);

file = fopen('vhdl','w+');

for x=1:640
    for y=1:480
        if ((x==100 || x==245 || x==390 || x==535) && (y>=20 && y<460))
            for(i=0:4)
                VRAM(y,x+i) = 255;
            end;
        end;
        
        if ((y==20 || y==165 || y==310 || y==455) && (x>=100 && x<540))
            for(i=0:4)
                VRAM(y+i,x) = 255;
            end;
        end;
        
        if(VRAM(y,x) == 255)
            addr = bin2dec([dec2bin(y-1,9) dec2bin(x-1,10)]);
            line = sprintf('%d => x"%X",\n',addr,VRAM(y,x));
            fwrite(file,line);
            %display(line);
        end;
        
    end;
end;

fclose(file);

figure();
imshow(VRAM);