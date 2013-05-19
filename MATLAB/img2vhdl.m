function [ result ] = img2vhdl(img_path, nb_bits_x, nb_bits_y)
    %img2vhdl
    %   -> transforme l'image donnée en VHDL pour ROM 8 bits
    %   img_path  : chemin de l'image
    %   nb_bits_x : nombre de bits pour l'adresse des X
    %   nb_bits_y : nombre de bits pour l'adresse des Y
      
    % recup de l'image
    img = imread(img_path);

    % passage de 8 bits à 3 ou 2
    img_R = (img(:,:,1)/255);
    img_G = (img(:,:,2)/255);
    img_B = (img(:,:,3)/255);
    
    % Pour chaque x/y
    data = [];
    for y = 1:size(img,1)
        for x = 1:size(img,2)
            % calcul de l'adresse du pixel
            addr = (y-1)*(2^nb_bits_x) + (x-1);
                
            % calcul de la valeur du pixel
            pixel = img_R(y,x) | img_G(y,x)| img_B(y,x);
            
            % création du VHDL du pixel
            line = sprintf('\t\t%d => ''%d'',\n',addr,pixel);          
            data = [data line];
        end;
    end;
    
    result = data;
end

