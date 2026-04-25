function senial_demodulada = demodulador_8psk(mensaje)
    constelacion = [1+0*1i; 1/sqrt(2)+1i/sqrt(2); -1/sqrt(2)+1i/sqrt(2); 0+1i; 1/sqrt(2)-1i/sqrt(2); 0-1i; -1+0*1i; -1/sqrt(2)-1i/sqrt(2)];
    bits = [0,0,0; 0,0,1; 0,1,0; 0,1,1; 1,0,0; 1,0,1; 1,1,0; 1,1,1];
    senial_demodulada = zeros(1,length(mensaje)*3);
    for i=1:length(mensaje)
        simbolo_recibido = mensaje(i);
        distancia = abs(constelacion - simbolo_recibido);
        [~,idx] = min(distancia);
        pos_mensaje = (i-1)*3 +1;
        senial_demodulada(pos_mensaje:pos_mensaje+2) = bits(idx, :);
    end
end