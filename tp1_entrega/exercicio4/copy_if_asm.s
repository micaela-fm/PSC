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
	push	%rbx
	push	%r12
	push	%r13
	push	%r14
	push	%r15

	mov		%rdi, %rbx			# dst_iter = dst
	mov		%rdi, %r13			# save dst
	mov		%rsi, %r15			# iter = src
	mov		%rcx, %r14			# save elem_size

	# last = src + src_size * elem_size
	mov		%rdx, %r12
	imul	%r14, %r12
	add		%r15, %r12

for:
	cmp		%r12, %r15			# iter < last
	jge		for_end

if:
	push	%r8
	push	%r9
	mov		%r15, %rdi			# 1st arg: iter
	mov		%r9, %rsi			# 2nd arg: context
	call 	*%r8				# predicate(iter, context)
	pop		%r9
	pop		%r8
	test	%rax, %rax
	jz		if_end

	mov		%rbx, %rdi			# 1st arg: dst_iter
	mov		%r15, %rsi			# 2nd arg: iter
	mov		%r14, %rdx			# 3rd arg: elem_size
	call	memcpy				# memcpy(dst_iter, iter, elem_size);
	add		%r14, %rbx			# dst_iter += elem_size;
if_end:

	add		%r14, %r15			# iter += elem_size
	jmp 	for
for_end:

	# return (dst_iter - orig_dst) / elem_size
	mov		%rbx, %rax
	sub		%r13, %rax
	xor		%rdx, %rdx
	div		%r14

	pop		%r15
	pop		%r14
	pop		%r13
    pop		%r12
    pop		%rbx
	ret

	.section	.note.GNU-stack

