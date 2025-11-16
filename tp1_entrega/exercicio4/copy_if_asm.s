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
	mov		%rdi, %r10			# *iter = dst
	mov		%rdi, %r11			# *dst_iter = dst
	push	%r12				
	xor		%r12, %r12
	imul	%rcx, %rdx, %r12	# last = src_size * elem_size
	add		%rsi, %r12			# last += src
	mov		%rsi, %r10			# iter = src
for:
	cmp		%r12, %r10			# iter < last
	jge		for_end
if:
	push	%rdi
	mov		%r10, %rdi			# 1st arg: iter
	mov		%r9, %rsi			# 2nd arg: context
	call 	(%r8)				# predicate(iter, context)
	pop		%rdi
	cmp		$0, %rax
	jz		if_end
	# TODO: memcpy(dst_iter, iter, elem_size)
	add		%rcx, %r11			# dst_iter += elem_size;
if_end:
	add		%rcx, %r10			# iter += elem_size
	jmp 	for
for_end:
	pop		%r12
	mov		%rdi, %rax			# rax = dst
	div		%rcx				# dst /= elem_size
	sub		%rax, %r11			# dst_iter -= dst
	mov		%r11, %rax			# return r11
	ret

	.section	.note.GNU-stack

