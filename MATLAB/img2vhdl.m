function [ result ] = img2vhdl(img_path, nb_bits_x, nb_bits_y)
    %img2vhdl
    %   -> transforme l'image donn�e en VHDL pour ROM 8 bits
    %   img_path  : chemin de l'image
    %   nb_bits_x : nombre de bits pour l'adresse des X
    %   nb_bits_y : nombre de bits pour l'adresse des Y
      
    % recup de l'image
    img = imread(img_path);
    
    % conversion uint8 -> double pour calculs
    img = double(img);

    % passage de 8 bits � 3 ou 2
    img_R = round(img(:,:,1)/255);
    img_G = round(img(:,:,2)/255);
    img_B = round(img(:,:,3)/255);
    
    % Pour chaque x/y
    data = [];
    for y = 1:size(img,1)
        for x = 1:size(img,2)
            % calcul de l'adresse du pixel
            addr = bin2dec([dec2bin(y-1,nb_bits_y) dec2bin(x-1,nb_bits_x)]);
                
            % calcul de la valeur du pixel
            %pixel = [dec2bin(img_B(y,x),2) dec2bin(img_G(y,x),3) dec2bin(img_R(y,x),3)];
            pixel = img_R(y,x) | img_G(y,x)| img_B(y,x);
            
            % cr�ation du VHDL du pixel
            line = sprintf('\t\t%d => ''%d'',\n',addr,pixel);          
            data = [data line];
        end;
    end;
    
    result = data;
end

