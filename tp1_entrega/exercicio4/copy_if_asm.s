/*
size_t copy_if(void *dst, void *src, size_t src_size, size_t elem_size,
				int (*predicate)(const void *, const void *), const void *context) {
	char *iter, *dst_iter = dst;
	char *last = (char *)src + src_size * elem_size;
	for (iter = src; iter < last ; iter += elem_size)
		if (predicate(iter, context)) {
			memcpy(dst_iter, iter, elem_size);
			dst_iter += elem_size;
		}
	return (dst_iter - (char*)dst) / elem_size;
}
*/
	.text
	.global	copy_if
copy_if:

	ret

	.section	.note.GNU-stack

