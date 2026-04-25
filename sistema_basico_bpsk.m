clc;
clearvars all;
%close all;

n_bits = 1e3;
datos_originales = randi([0 1],1,n_bits);

bits_codificados_hamming = codificar_hamming(datos_originales);

bits_codificados_convolucion = codificar_convolucion(datos_originales , [171 , 133]);


simbolos_hamming = modulador_bpsk(bits_codificados_hamming);
simbolos_convolucion = modulador_bpsk(bits_codificados_convolucion);


%SNR_dB = [0 5 10 15];
SNR_dB = 0:1:15;
EbNo = 10.^(SNR_dB/10);

BER_Hamming = zeros(1,length(SNR_dB));
for snr = SNR_dB
    snr_ajustado_hamming = snr + 10*log10(4/7);
    senial_ruidosa = canal_awgn(simbolos_hamming,snr_ajustado_hamming);
    %{
    if(mod(snr,5)==0)
        constelacion(senial_ruidosa,snr,'BPSK','Hamming(7,4)');
    end
    %}
    bits_demodulados_hamming = demodulador_bpsk(senial_ruidosa);
    bits_decodificados_hamming = decodificar_hamming(bits_demodulados_hamming);
    errores = sum(xor(datos_originales , bits_decodificados_hamming));
    BER_Hamming(snr+1) = errores/length(datos_originales);
end


BER_Viterbi = zeros(1,length(SNR_dB));
for snr = SNR_dB
    snr_ajustado_viterbi = snr + 10*log10(1/2);
    senial_ruidosa_2 = canal_awgn(simbolos_convolucion,snr_ajustado_viterbi);
    %{
    if (mod(snr,5)==0)
        constelacion(senial_ruidosa_2,snr,'BPSK','Viterbi');
    end
    %}
    bits_demodulados_convolucion = demodulador_bpsk(senial_ruidosa_2);
    bits_decodificados_viterbi = decodificar_viterbi(bits_demodulados_convolucion);
    errores = sum(xor(datos_originales , bits_decodificados_viterbi));
    BER_Viterbi(snr+1) = errores/length(datos_originales);
end


% probalibiliad de error por bit en BPSK
M=2;
SER_teorico_BPSK = 2*qfunc(sqrt(2*log2(M)*EbNo*(sin(pi/M)^2)));
k = log2(M); 
BER_teorico_BPSK = SER_teorico_BPSK/k;

% Graficas
figure;
semilogy(SNR_dB, BER_teorico_BPSK, 'r', 'LineWidth', 2); 
hold on;
semilogy(SNR_dB,BER_Hamming, 'bo--', 'MarkerFaceColor', 'b');
semilogy(SNR_dB, BER_Viterbi, 'go--', 'MarkerFaceColor', 'g');
grid on;
xlabel('SNR (dB)');
ylabel('Bit Error Rate (BER)');
legend('Teórico (BPSK)','Hamming','Viterbi');
title('Análisis de Desempeño: BER vs SNR con Modulación BPSK');