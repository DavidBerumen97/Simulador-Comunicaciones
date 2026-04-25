function constelacion(simbolos,snr_db,modulacion,codificacion)
    scatterplot(simbolos);
    grid on;
    xline(0, 'w-', 'LineWidth', 2); 
    yline(0, 'w-', 'LineWidth', 2);
    title(sprintf('Diagrama de Constelación (SNR = %d dB), en modulacion = %s y codificacion = %s', snr_db,modulacion,codificacion));
end