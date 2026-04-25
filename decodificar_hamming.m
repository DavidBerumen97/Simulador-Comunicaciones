function mensaje_decodificado = decodificar_hamming(senial)
    longitud_valida = floor(length(senial)/7) * 7;
    senial = senial(1:longitud_valida);

    longitud = length(senial);
    mensaje_decodificado = zeros(1,longitud*4/7);
    P = [1 1 0;
         0 1 1;
         1 1 1;
         1 0 1];
    H = [P' eye(3)];
    
    k = [0 ,3, 6, 7, 5, 1, 2, 4];
    v = [zeros(1,7);eye(7)];
    mapeo_errores = dictionary(k(:),num2cell(v,2));

    for i=1:7:longitud
        palabra = senial(i:i+6); 
        S = mod(palabra*H',2);
        bit_error = S(1)*2^0 + S(2)*2^1 + S(3)*2^2;
        error = cell2mat(mapeo_errores(bit_error));
        palabra = mod(error + palabra,2);
        original = palabra(1:4);
        pos_inicio = ((i-1) * 4/7) + 1;
        mensaje_decodificado(pos_inicio : pos_inicio+3) = original;
    end
end

%% pagina 73 de error controling code.