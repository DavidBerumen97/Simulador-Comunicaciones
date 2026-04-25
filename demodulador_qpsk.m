function senial_demodulada = demodulador_qpsk(simbolos)
    senial_demodulada = zeros(1,length(simbolos)*2);
    i = 1;
    for num = simbolos
        if imag(num)>=0
            senial_demodulada(i) = 0;
            if real(num)>=0
                senial_demodulada(i+1) = 0;
            else
                senial_demodulada(i+1) = 1;
            end
        else
            senial_demodulada(i) = 1;
            if real(num)>=0
                senial_demodulada(i+1) =  0;
            else
                senial_demodulada(i+1) = 1;
            end
        end
        i = i+2;
    end
end
