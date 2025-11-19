#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define ARRAY_SIZE(a)  sizeof a / sizeof a[0]

size_t copy_if(void *dst, void *src, size_t src_size, size_t elem_size, 
    int (*predicate)(const void *, const void *), const void *context);

int greater_than(const void *elem, const void *context) {
    int value = *(int *)elem;
    int threshold = *(int *)context;
    return value > threshold;
}

int main() {
    int src_array[] = {1, 5, 3, 10, 7, 2, 8};
    size_t src_size = ARRAY_SIZE(src_array);

    int dst_array[src_size];

    int threshold = 5;

    size_t copied_elements = copy_if(dst_array, src_array, src_size, sizeof(int), greater_than, &threshold);

    printf("Source array:\n");
    for (size_t i = 0; i < src_size; i++) {
        printf("%d ", src_array[i]);
    }
    printf("\n");
    
    printf("Elements greater than %d:\n", threshold);
    for (size_t i = 0; i < copied_elements; i++) {
        printf("%d ", dst_array[i]);
    }
    printf("\n");
}
