function [senial_filtrada,h]=filtro_conformador( bits_cod , roll_off , spp)
    span = spp;
    h = rcosdesign(roll_off, span, spp, 'sqrt');
    
    senial_filtrada = upfirdn(bits_cod, h, spp);

end