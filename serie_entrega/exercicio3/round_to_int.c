union Float {
    float f;
    unsigned i;
    struct {
        unsigned mantissa: 23;
        unsigned exponent: 8;
        unsigned signal: 1;
    };
};

bool round_to_int(float fvalue, int *ivalue) {
    union Float value;
    value.f = fvalue;

    int signal = 1;
    if (value.signal)
    {
        signal = -1;
    }

    int exponent = value.exponent - 127;
    int mantissa_unnormalized = value.mantissa | (1 << 23);                 // becomes 1.mantissa
    int mantissa_shifted = mantissa_unnormalized >> (22 - exponent);        // lsb of mantissa in position 0
    
    int value_floor = (mantissa_shifted >> 1) & ~(~0 << (exponent + 1));    // removes decimal bits & filters integer bits

    bool round_up = mantissa_shifted & 1;                                   // must round up if first bit of mantissa is 1 (0.5)
    
    *ivalue = (value_floor + round_up) * signal;                            // signal affects both the value and the round-up correction

    return true;
}
