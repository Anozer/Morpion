function [ addr ] = coord2addr( x, y, option, bitsX, bitsY)
    if(strcmp(option,'bin'))
        addr = ([dec2bin(y-1,bitsY) dec2bin(x-1,bitsX)]);
    elseif(strcmp(option,'dec'))
        addr = bin2dec([dec2bin(y-1,bitsY) dec2bin(x-1,bitsX)]);
    end;
end

