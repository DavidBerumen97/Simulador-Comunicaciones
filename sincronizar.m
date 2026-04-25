function simbolos_sinc = sincronizar(pulsos_recibidos)
    span = 8;
    spp = span;
    retraso = span * spp;

    senial_retrasada = pulsos_recibidos(retraso +1 : end);

    simbolos_sinc = senial_retrasada(1:spp:end);

end
