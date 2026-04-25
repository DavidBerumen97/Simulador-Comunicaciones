function senial_ruido = canal_awgn(mensaje,snr_db)
    potencia_ruido = (sum(abs(mensaje).^2)/length(mensaje))/(10^(snr_db/10));
    varianza = potencia_ruido/2;
    desviacion = sqrt(varianza);
    ruido_real = desviacion * randn(1,length(mensaje));
    ruido_imaginario = desviacion * randn(1,length(mensaje));
  
    n = ruido_real +ruido_imaginario*1i;

    senial_ruido = mensaje + n;
end