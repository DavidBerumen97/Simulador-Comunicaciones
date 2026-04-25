clc;
clearvars all;
close all;



datos_originales = randi([0 1],1,1e5);
bits_codificados_hamming = codificar_hamming(datos_originales);

simbolos = modulador_8psk(bits_codificados_hamming);

SNR_dB = 0:1:15;
for snr = SNR_dB
    snr_ajustado_hamming = snr + 10*log10(3 * (4/7));
    senial_ruidosa = canal_awgn(simbolos,snr_ajustado_hamming);
    if(mod(snr,5)==0)
        constelacion(senial_ruidosa,snr,'8-PSK','Hamming(7,4)');
    end
    mensaje_demodulado = demodulador_8psk(senial_ruidosa);
    mensaje_decodificado = decodificar_hamming(mensaje_demodulado);
end



