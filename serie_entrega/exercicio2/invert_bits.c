/*
Programe a função invert_bits que inverte o valor de uma sequência de bits pertencentes a value. 
A sequência começa na posição position e abrange nbits posições. 
A função retorna o valor alterado.
*/

int invert_bits(int value, int position, int nbits) {
    const unsigned long mask = ~(~0L << nbits) << position; 
    return value ^ mask; 
}