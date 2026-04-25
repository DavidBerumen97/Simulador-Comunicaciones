function senial_demodulada = demodulador_bpsk(simbolos)
    senial_demodulada = zeros(1,length(simbolos));
    i = 1;
    for num = simbolos
        if real(num)>=0
            senial_demodulada(i) = 1;
        else
            senial_demodulada(i) = 0;
        end
        i = i+1;
    end
    
end