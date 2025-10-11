#include <stddef.h>

struct hmstime
{
    unsigned short hours;
    unsigned char minutes;
    unsigned char seconds;
};

void sumtimes(struct hmstime *res, const struct hmstime times[], size_t ntimes)
{
    int seconds = 0; 
    int minutes = 0; 
    int hours = 0;

    for (size_t i = 0; i < ntimes; i++)
    {
        seconds += times[i].seconds;
        minutes += times[i].minutes;
        hours += times[i].hours;
    }

    minutes += seconds / 60; 
    seconds %= 60; 

    hours += minutes / 60; 
    minutes %= 60; 


    res->seconds = seconds;
    res->minutes = minutes;
    res->hours = hours;    
}
