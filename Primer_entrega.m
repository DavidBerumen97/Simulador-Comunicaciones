clc;
clearvars all;
close all;


n_bits = 1e3;
datos_originales = randi([0 1],1,n_bits);

bits_codificados_hamming = codificar_hamming(datos_originales);

simbolos_hamming = modulador_qpsk(bits_codificados_hamming);

SNR_tabla = [0 5 10 15];
BER_tabla = zeros(1,length(SNR_tabla));

SNR_dB = 0:1:15;
EbNo = 10.^(SNR_dB/10);

%Probablidad de error de QPSK
M=4;
SER_teorico_QPSK = 2*qfunc(sqrt(2*log2(M)*EbNo*(sin(pi/M)^2)));
k = log2(M);
BER_teorico_QPSK = SER_teorico_QPSK/k;

BER_Hamming = zeros(1,length(SNR_dB));
i=1;
for snr = SNR_dB
    snr_ajustado_hamming = snr + 10*log10(k * (4/7));
    senial_ruidosa = canal_awgn(simbolos_hamming,snr_ajustado_hamming);
    bits_demodulados_hamming = demodulador_qpsk(senial_ruidosa);
    bits_decodificados_hamming = decodificar_hamming(bits_demodulados_hamming);
    errores = sum(xor(datos_originales , bits_decodificados_hamming));
    BER_Hamming(snr+1) = errores/length(datos_originales);
    if(mod(snr,5)==0)
        BER_tabla(i) = BER_Hamming(snr+1);
        i = i+1;
    end
end

% Graficas y Tablas
table(SNR_tabla',BER_tabla','VariableNames',{'SNR','BER'})
figure;
semilogy(SNR_dB, BER_teorico_QPSK, 'r', 'LineWidth', 2); 
hold on;
semilogy(SNR_dB,BER_Hamming, 'bo--', 'MarkerFaceColor', 'b');
grid on;
xlabel('SNR (dB)');
ylabel('Bit Error Rate (BER)');
legend('Teórico (QPSK)','Hamming');
title('Análisis de Desempeño: BER vs SNR en modulación QPSK');
