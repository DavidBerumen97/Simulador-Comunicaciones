function senial_modulada = modulador_qpsk(mensaje)
    qpsk = [1+1i;1-1i;-1+1i;-1-1i];
    senial_modulada = zeros(1,length(mensaje)/2);
    for i=1:length(mensaje)/2
        pos_mensaje = (i-1)*2 +1;
        mapeo_qpsk = (mensaje(pos_mensaje)*1) + (mensaje(pos_mensaje+1)*2);
        senial_modulada(i) = qpsk(mapeo_qpsk+1);
    end
end