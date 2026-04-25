clc;
clearvars all;
close all;

% Parte de trasnmision
n_bits = 1e7;
datos_originales = randi([0 1],1,n_bits);

bits_codificados_hamming = codificar_hamming(datos_originales);
bits_codificados_convolucion = codificar_convolucion(datos_originales , [171 , 133]);
bit_modulados = modulador_qpsk(bits_codificados_hamming);

L = length(bit_modulados);

[pulsos,h] =  filtro_conformador(bit_modulados,0.3,8);

SNR_tabla = [0 5 10 15];
BER_tabla = zeros(1,length(SNR_tabla));

SNR_dB = 0:1:15;
EbNo = 10.^(SNR_dB/10);

BER_Hamming = zeros(1,length(SNR_dB));
i=1;
for snr = SNR_dB
    %canal
    snr_ajustado_hamming = snr + 10*log10(2 * (4/7));
    senial_ruidosa = canal_awgn(pulsos,snr_ajustado_hamming);
    %Recepcion

    recibido = filter(h,1,senial_ruidosa);
    simbolos_sinc = sincronizar (recibido);

    simbolos_sinc = simbolos_sinc(1:L);
    bits_demodulados = demodulador_qpsk(simbolos_sinc);
    bits_decodificados = decodificar_hamming(bits_demodulados);
    errores = sum(xor(datos_originales,bits_decodificados));
    BER_Hamming(snr+1) = errores/length(datos_originales);
    if(mod(snr,5)==0)
        BER_tabla(i) = BER_Hamming(snr+1);
        i = i+1;
    end
end

% probalibiliad de error por bit en QPSK
M=4;
SER_teorico_QPSK = 2*qfunc(sqrt(2*log2(M)*EbNo*(sin(pi/M)^2)));
k = log2(M); 
BER_teorico_QPSK = SER_teorico_QPSK/k;

table(SNR_tabla',BER_tabla','VariableNames',{'SNR','BER'})
figure;
semilogy(SNR_dB, BER_teorico_QPSK, 'r', 'LineWidth', 2); 
hold on;
semilogy(SNR_dB,BER_Hamming, 'bo--', 'MarkerFaceColor', 'b');
xlabel('SNR (dB)');
ylabel('Bit Error Rate (BER)');
legend('Teórico (QPSK)','Hamming');
title('Análisis de Desempeño: BER vs SNR en modulación QPSK');





