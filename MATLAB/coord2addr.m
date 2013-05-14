function [ addr ] = coord2addr( x, y, option)
    if(strcmp(option,'bin'))
        addr = ([dec2bin(y-1,9) dec2bin(x-1,10)]);
    elseif(strcmp(option,'dec'))
        addr = bin2dec([dec2bin(y-1,9) dec2bin(x-1,10)]);
    end;
end

