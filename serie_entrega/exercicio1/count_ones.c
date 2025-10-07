#include <stdio.h>

int count_ones(int value) {
    int ones_counter = 0;
    unsigned int u_value = value;

    while ( u_value != 0) {
        if (u_value & 1u) {
            ones_counter++;
        }
        u_value = u_value >> 1;
    }

    return ones_counter;
}
