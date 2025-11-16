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
	mov		%rdi, %r11			# dst_iter = dst
	push	%rdi
	push	%r12	
	mov		%rdx, %r12		
	imul	%rcx, %r12			# last = src_size * elem_size
	add		%rsi, %r12			# last += src
	mov		%rsi, %r10			# iter = src
for:
	cmp		%r12, %r10			# iter < last
	jge		for_end
if:
	push	%r10
	push	%r11	
	push	%rcx
	push	%rsi
	mov		%r10, %rdi			# 1st arg: iter
	mov		%r9, %rsi			# 2nd arg: context
	call 	*%r8				# predicate(iter, context)
	pop		%rsi
	pop		%rcx
	pop		%r11
	pop		%r10
	test	%rax, %rax
	jz		if_end
	push	%rcx
	push	%r10
	push	%r11
	mov		%r11, %rdi			# 1st arg: dst_iter
	mov		%r10, %rsi			# 2nd arg: iter
	mov		%rcx, %rdx			# 3rd arg: elem_size
	call	memcpy				# memcpy(dst_iter, iter, elem_size);
	pop		%r11
	pop		%r10
	pop		%rcx
	add		%rcx, %r11			# dst_iter += elem_size;
if_end:
	add		%rcx, %r10			# iter += elem_size
	jmp 	for
for_end:
	pop		%r12
	pop		%rdi
	mov		%r11, %rax
	sub		%rdi, %rax
	xor		%rdx, %rdx
	div		%rcx
	ret

	.section	.note.GNU-stack

