function senial_modulada = modulador_bpsk(mensaje)
    bpsk = [1+0*1i;-1+0*1i];
    senial_modulada = zeros(1,length(mensaje));
    for n=1:length(mensaje)
        bit_mensaje = mensaje(n);
        if(bit_mensaje == 1)
            senial_modulada(n) = bpsk(1);
        else
            senial_modulada(n) = bpsk(2);
        end
    end
end