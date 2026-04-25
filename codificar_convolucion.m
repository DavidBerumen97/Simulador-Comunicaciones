%% ejemplo  convolucion 

function bits_codificados = codificar_convolucion (datos , g_octal)
    c = cell(1,length(g_octal));
    for i=1:length(g_octal)
        G = dec2bin(oct2dec(g_octal(i))) - '0';
        c{i} = mod(convolucion(datos,G),2);
    end
 
    bits_codificados = zeros(1,2*length(c{1}));
    for i=1:length(c{1})
        pos_inicial = (i-1)*2 + 1;
        bits_codificados(pos_inicial:pos_inicial+1) = [c{1}(i),c{2}(i)];
    end

end