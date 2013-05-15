function [ result ] = img2vhdl(img_path, nb_bits_x, nb_bits_y)
    %img2vhdl
    %   -> transforme l'image donnée en VHDL pour ROM 8 bits
    %   img_path  : chemin de l'image
    %   nb_bits_x : nombre de bits pour l'adresse des X
    %   nb_bits_y : nombre de bits pour l'adresse des Y
     
    nb_line = 2^(nb_bits_x+nb_bits_y);
    data_format = '%02x,\n';
    
    
    data = sprintf('memory_initialization_radix=16;\nmemory_initialization_vector=\n');

    
    % recup de l'image
    img = imread(img_path);
    
    % conversion uint8 -> double pour calculs
    img = double(img);

    % passage de 8 bits à 3 ou 2
    img_R = round(img(:,:,1)*7/255);
    img_G = round(img(:,:,2)*7/255);
    img_B = round(img(:,:,3)*3/255);
    
    % Pour chaque x/y
    new_addr = -1;
    for y = 1:size(img,1)
        for x = 1:size(img,2)
            % calcul de l'adresse du pixel
            last_addr = new_addr;
            new_addr = bin2dec([dec2bin(y-1,nb_bits_y) dec2bin(x-1,nb_bits_x)]);
            
            % calcul de la valeur du pixel
            pixel = bin2dec([dec2bin(img_B(y,x),2) dec2bin(img_G(y,x),3) dec2bin(img_R(y,x),3)]);

            
            if(new_addr ~= last_addr+1)
                diff = new_addr - last_addr-1;
                for i=1:diff
                    line = sprintf(data_format, 0);
                    data = [data line];
                end;
            end;
            
            
            % création du VHDL du pixel
            line = sprintf(data_format, pixel);
            data = [data line];
        end;
    end;
    
    if(new_addr+1 ~= nb_line-1)
        diff = nb_line-1 - new_addr;
        for i=1:diff
            line = sprintf(data_format, 0);
            data = [data line];
        end;
    end;
    
    data(length(data)-1) = ';';
    
    result = data;
end

