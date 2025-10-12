#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <getopt.h>
#include <string.h>
#include <strings.h>

#define MAX_LINES 100000
#define MAX_LINE_LENGTH 1000

bool case_sensitive = false;
bool descending_order = false;

int cmp_lines(const void *line_a, const void *line_b) {
    const char *pointer_a = *(const char * const *)line_a;
    const char *pointer_b = *(const char * const *)line_b;
    int result = case_sensitive ? strcmp(pointer_a, pointer_b) : strcasecmp(pointer_a, pointer_b);
    return descending_order ? -result : result;
}

int main(int argc, char *argv[]) {
    int option;
    char *input_file = NULL;
    char *output_file = NULL;

    // read options
    while ((option = getopt(argc, argv, "i:o:cr")) != -1) {
        switch (option)
        {
        case 'i':
            input_file = optarg;
            break;
        case 'o': 
            output_file = optarg;
            break;
        case 'c':
            case_sensitive = true;
            break;
        case 'r': 
            descending_order = true; 
            break;
        default:
            return 1;
        }
    }

    FILE *input = input_file ? fopen(input_file, "r") : stdin;
    FILE *output = output_file ? fopen(output_file, "w") : stdout;

    static char lines[MAX_LINES][MAX_LINE_LENGTH];
    static char *pointers[MAX_LINES];
    int current_line = 0;

    // save the input's lines to an array of lines
    // save the pointers to lines to an array of pointers
    while (current_line < MAX_LINES && fgets(lines[current_line], MAX_LINE_LENGTH, input)) {
        pointers[current_line] = lines[current_line];
        current_line++;
    }

    // sort the array of lines
    qsort(pointers, current_line, sizeof(pointers[0]), cmp_lines);

    for (int i = 0; i < current_line; ++i) {
        fputs(pointers[i], output);
    }

    if (input != stdin) fclose(input);
    if (output != stdout) fclose(output);

    return 0;
}
