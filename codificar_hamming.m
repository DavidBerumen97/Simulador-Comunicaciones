function mensaje_codificado = codificar_hamming(mensaje)
    longitud = length(mensaje);
    mensaje_codificado = zeros(1,longitud*7/4);
    P = [1 1 0;
         0 1 1;
         1 1 1;
         1 0 1];
    G = [eye(4) P];
    
    for i=1:4:longitud
        palabra_original = mensaje(i:i+3);
        palabra = mod(palabra_original*G,2);
        pos_inicio = ((i-1) * 7/4) + 1;
        mensaje_codificado(pos_inicio:pos_inicio+6) = palabra;
    end
end