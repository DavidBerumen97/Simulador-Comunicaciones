function resultado = distancia(bits_entrada,bits_siguientes)
    resultado = sum(xor(bits_entrada,bits_siguientes));
end
