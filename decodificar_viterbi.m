function mensaje = decodificar_viterbi(senal_entrada)
    
    longitud_mensaje = floor(length(senal_entrada)/2);
    bits_decodificados = zeros(1,longitud_mensaje);

    %% Mapeo de estados
    K = 7; %Tamaño de los resgistros
    num_estados = 2^(K-1);

    g = [171,133];

    Siguientes_estados = zeros(num_estados,2);
    Salidas = zeros(num_estados,2,2);

    g_1 = dec2bin(oct2dec(g(1))) - '0';
    g_2 = dec2bin(oct2dec(g(2))) - '0';

   
    for s = 0:num_estados-1
        for bit_entrada = 0:1
            siguiente_estado = bitshift(s,-1) + bitshift(bit_entrada,K-2);
            Siguientes_estados(s+1,bit_entrada+1) = siguiente_estado+1;

            registro = [bit_entrada,dec2bin(s,K-1)-'0'];
            
            salida_1 = mod(sum(registro.*g_1),2);
            salida_2 = mod(sum(registro .*g_2),2);

            Salidas(s+1,bit_entrada+1,:) = [salida_1 , salida_2];
        end
    end
    
    

    %% Mapeo de metricas de medida
        
    Metricas_camino = ones(1,num_estados) * 1e6;
    Metricas_camino(1) = 0;
        

    Supervivientes = zeros(longitud_mensaje,num_estados);

    for t=1:longitud_mensaje
        bits_recibidos = senal_entrada(2*t-1 : 2*t);
        % recorrer nuestras matrices de alida y comparar para encontrar la
        % mejor salida

        Metricas_temporales = ones(1,num_estados)*1e6;

        for s=1:num_estados
            if Metricas_camino(s) >= 1e6,continue; end

            % Entrada de un 0
            destino_0 = Siguientes_estados(s,1);
            salida_0 = squeeze(Salidas(s,1,:))';
            peso_rama_0 = distancia(bits_recibidos,salida_0);
            suma_0 = Metricas_camino(s) + peso_rama_0;

            if suma_0 < Metricas_temporales(destino_0)
                Metricas_temporales(destino_0) = suma_0;
                Supervivientes(t,destino_0) = s;
            end

            %Entrada de un 1
            destino_1 = Siguientes_estados(s,2);
            salida_1 = squeeze(Salidas(s,2,:))';
            peso_rama_1 = distancia(bits_recibidos,salida_1);
            suma_1 = Metricas_camino(s) + peso_rama_1;

            if suma_1 < Metricas_temporales(destino_1)
                Metricas_temporales(destino_1) = suma_1;
                Supervivientes(t,destino_1) = s;
            end
        end

        Metricas_camino = Metricas_temporales;
    end

    [~,estado_actual] = min(Metricas_camino);
    
    for t=longitud_mensaje:-1:1
        padre = Supervivientes(t,estado_actual);

        if(Siguientes_estados(padre,1) == estado_actual)
            bits_decodificados(t) = 0;
        else
            bits_decodificados(t) = 1;
        end
        estado_actual = padre;
    end
    

    mensaje = bits_decodificados(1:end-6);
   
end
