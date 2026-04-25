classdef FIFO < handle

    properties (Access = private)
        Elementos = []
    end

    methods
        function obj = FIFO()
        end

        function encolar(obj, item)
            obj.Elementos = [obj.Elementos,item];
        end

        function item = desencolar(obj)
            if obj.estaVacia()
                error('No se puede desencolar: cola vacia');
            end

            item = obj.Elementos(1);
            obj.Elementos(1) = [];
        end

        function item = verPrimero(obj)
            if obj.estaVacia()
                error('No se puede ver: esta vacia');
            end
            item = obj.Elementos(1);
        end

        function vacia = estaVacia(obj)
            vacia = isempty(obj.Elementos);
        end


        function encolarArreglo(obj,arreglo)
            for i = length(arreglo):-1:1
                obj.encolar(arreglo(i));
            end
        end

        function copia = verCompleta(obj)
            copia = obj.Elementos;
        end

        function tamanio = tamanioFIFO(obj)
            tamanio = length(obj.Elementos);
        end

        function items = desencolarCompleta(obj)
            items = [];
            while ~obj.estaVacia()
                valor = obj.desencolar();
                items = [items,valor];
            end
        end

        
    end
end

