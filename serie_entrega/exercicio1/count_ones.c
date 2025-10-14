#include <stdio.h>

int count_ones(int value) {
    int ones_counter = 0;
    unsigned int u_value = value;

    while ( u_value != 0) {
        ones_counter += u_value & 1u;
        u_value >>= 1;
    }

    return ones_counter;
}
