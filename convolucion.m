function resultado = convolucion(x_1,x_2)
    

    K = length(x_2); % Tamaño de nuestra funcion
    L = length(x_1); % Tamaño de nuestros datos

    fifo_x_2 = FIFO();
    fifo_x_2.encolarArreglo(x_2); %guardamos nuestra funcion y la volteamos para la convolucion
    
    elementos_totales_sumados = K+L-1;
    
    resultado = zeros(1,elementos_totales_sumados);
    
    
   % Memoria de nuestra convolucion
    registro = FIFO();
    for i = 1:K
        registro.encolar(0);
    end
    
    for i = 1:elementos_totales_sumados
        if i <= L
            valor_de_mensaje = x_1(i); %el valor actual del mensaje en ese momento
        else
            valor_de_mensaje = 0; 
        end
        
        registro.desencolar(); %suelta el ultimo valor
        registro.encolar(valor_de_mensaje); %agrega este nuevo valor

        bits_en_registro = registro.verCompleta(); %Muestra nuestro registro actual
    
        resultado(i) = sum(fifo_x_2.verCompleta()  .* bits_en_registro); %la operacion de convolucion como tal
        
    end 

end