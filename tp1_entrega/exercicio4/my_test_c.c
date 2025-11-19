#include <stdio.h>
#include <string.h>

#define ARRAY_SIZE(a)  sizeof a / sizeof a[0]

struct user {
    const char *name;
    int number;
};

size_t copy_if(void *dst, void *src, size_t src_size, size_t elem_size,
int (*predicate)(const void *, const void *), const void *context);

int name_contains(const void *elem, const void *context) {
    const struct user * const *user_ptr = (const struct user * const *)elem;
    const char *word = (const char *)context;
    return strstr((*user_ptr)->name, word) != NULL;
}

int main() {
    struct user u1 = {"Henrique Gouveia e Melo", 101};
    struct user u2 = {"Luís Marques Mendes", 102};
    struct user u3 = {"António José Seguro", 103};
    struct user u4 = {"André Ventura", 104};
    struct user u5 = {"João Cotrim de Figueiredo", 105};
    struct user u6 = {"Jorge Pinto", 106};
    struct user u7 = {"António Filipe", 107};
    struct user u8 = {"Catarina Martins", 108};

    struct user *src[] = {&u1, &u2, &u3, &u4, &u5, &u6, &u7, &u8};
    size_t src_size = ARRAY_SIZE(src);
    size_t elem_size = sizeof(struct user *);

    struct user *dst[src_size];

    const char *search_word = "António";

    size_t copied = copy_if(dst, src, src_size, elem_size, name_contains, search_word);

    printf("Found %zu student(s) named %s\n", copied, search_word);
    for (size_t i = 0; i < copied; i++) {
        printf("Number: %d, Name: %s\n", dst[i]->number, dst[i]->name);
    }
}
