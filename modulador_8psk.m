function senial_modulada = modulador_8psk(mensaje)
    constelacion = [1+0*1i; 1/sqrt(2)+1i/sqrt(2); -1/sqrt(2)+1i/sqrt(2); 0+1i; 1/sqrt(2)-1i/sqrt(2); 0-1i; -1+0*1i; -1/sqrt(2)-1i/sqrt(2)];
    norma_3 = mod(length(mensaje),3);
    if norma_3 == 1
        mensaje(end+1:end+2) = 0;
    elseif norma_3 == 2
        mensaje(end+1) = 0;
    end
    senial_modulada = zeros(1,length(mensaje)/3);
    for i=1:length(mensaje)/3
        pos_mensaje = (i-1)*3 +1;
        mapeo = (mensaje(pos_mensaje)*4) + (mensaje(pos_mensaje+1)*2) +(mensaje(pos_mensaje+2)*1);
        senial_modulada(i) = constelacion(mapeo+1);
    end
end