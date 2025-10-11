#include <string.h>

void string_detab(char *string, int tab_size)
{
    char new_string[100];

    int i = 0;      // current char in string
    int j = 0;      // current char in new_string
    int column = 0; // current char in column

    while (string[i] != '\0')
    {
        if (string[i] == '\n') 
        {
            column = 0;
        }

        if (string[i] == '\t')
        {
            int spaces = tab_size - (column % tab_size);
            for (int k = 0; k < spaces; k++)
            {
                new_string[j++] = ' ';
                column++;
            }
        }
        else
        {
            new_string[j++] = string[i];
            column++;
        }
        i++;
    }

    new_string[j] = '\0'; 

    strcpy(string, new_string);
}
