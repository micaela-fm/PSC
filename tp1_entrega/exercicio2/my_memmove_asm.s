/*
void *my_memmove(void *dst, const void *src, size_t len);
*/
	.text
	.globl my_memmove
my_memmove:
	mov		%rdi, %rax		# copy dst to return register
	mov		%rdx, %r8		# save len for 2nd loop
src_to_stack:
	dec		%rsp			# allocate 1 byte in stack
	mov		(%rsi), %cl		# 1 byte of src to rcx
	mov		%cl, (%rsp)		# byte to stack
	inc		%rsi			# move src pointer to next byte
	dec 	%rdx			# len--
	jnz		src_to_stack
	add		%r8, %rdi		# move dst to end byte
	dec		%rdi
stack_to_dst:
	mov		(%rsp), %cl		# 1 byte of stack to rcx
	mov		%cl, (%rdi)		# byte to dst
	dec		%rdi			# move stack and dst pointers to next byte
	inc		%rsp
	dec 	%r8				# len--
	jnz		stack_to_dst
end:
	ret

	.section	.note.GNU-stack
